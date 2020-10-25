from django.http import HttpResponse
from django.template import loader
from django.views.generic import View
from django.contrib.auth import authenticate, login
from django.shortcuts import redirect
from main.models.mlm_invite import  Invite
from main.models.mlm_user_profile import UserProfile
from mailer import Mailer
from main.models.mlm_invite import Invite
from django.utils import  timezone
from django.http import HttpResponseNotFound,JsonResponse
from main.models.mlm_user_profile import UserProfile
import json
from django.contrib.auth.models import User
from django.conf import settings #this imports also your specific settings.py
from django.contrib import messages
from main.models.mlm_user_hierarchy import UserHierarchy

def get_user_hierarchy(user_id,level=0,ha_list=[]):
    level=0
    p_auth_user_obj = User.objects.get(id=user_id)
    p_user_profile_obj = UserProfile.objects.get(auth_user_id=user_id)
    image="/static/img/nobody.jpg"
    if p_user_profile_obj.picture:
        image=p_user_profile_obj.picture.url
    data={
        "text": {
            "name": p_auth_user_obj.first_name+" "+p_auth_user_obj.last_name,
            "title": p_user_profile_obj.designation,
        },
        "image": image,
        "children":[]
    }

    ha_list.append(data)
    user_h_ds=UserHierarchy.objects.filter(parent_id=user_id)
    for uh in user_h_ds:

        level=get_user_hierarchy(uh.user_id,level,data['children'])

    level+=1
    # level = 0 => student
    # level = 1 => prefect
    # level = 2 => bursar
    # level = 3 => Scholar
    print("User_id", user_id,level)

    if len(user_h_ds) == 0:
        return level


    if level == 1:
        data["text"]["title"] = "Student"
    elif level == 2:
        data["text"]["title"] = "Prefect"
    elif level == 3:
        data["text"]["title"] = "Bursar"
    elif level == 4:
        data["text"]["title"] = "Scholar"
    return level
class HomePage(View):

    def dashboard(request):
        if not request.user.is_authenticated:
            return redirect('/login')
        else:
            template = loader.get_template('home/dashboard_page.html')

            user_profile_obj_ds=User.objects.filter(is_superuser=False).all()
            user_data=[]
            for user_obj in user_profile_obj_ds:
                user_profile_obj=UserProfile.objects.get(auth_user_id=user_obj.id)

                user_data.append({"id": user_obj.id,"email": user_obj.email, "first_name": user_obj.first_name, "last_name": user_obj.last_name, "payment_status": user_profile_obj.payment_status, "date_joined": user_obj.date_joined})

            context = {
                "all_users": user_data,
            }

            return HttpResponse(template.render(context, request))

    def get_tree(request,user_id):
        user_ha_list=[]
        get_user_hierarchy(user_id, level=0, ha_list=user_ha_list)

        return JsonResponse(data=user_ha_list,safe=False)

    def index(request):
        if not request.user.is_authenticated:
            return redirect('/login')
        else:
            if request.user.is_superuser:
                return redirect("/dashboard")

            template = loader.get_template('home/home_page.html')
            invite_ds=Invite.objects.filter(user_id=request.user.id).all()
            user_id=request.user.id
            user_profile_obj_ds=UserProfile.objects.filter(auth_user_id=user_id)
            user_profile_obj={}
            if user_profile_obj_ds:
                user_profile_obj=user_profile_obj_ds.get()
            user_ha_list=[]
            get_user_hierarchy(request.user.id,level=1,ha_list=user_ha_list)
            print("Ha data",user_ha_list[0])
            context = {
                "invites": invite_ds,
                "user_profile_obj": user_profile_obj,
                "user_hierarchy": json.dumps(user_ha_list)
            }

            return HttpResponse(template.render(context, request))
    def update_payment_status(request):
        status=request.POST.get("status")
        user_ids_json=request.POST.get("user_ids")
        user_ids=json.loads(user_ids_json)

        UserProfile.objects.filter(auth_user_id__in=user_ids).update(payment_status=status)

        return redirect('/dashboard')

    def update_my_profile(request):
        mobile=request.POST.get("mobile")
        prefix=request.POST.get("prefix")
        picture=request.FILES.get("picture")
        user_id=request.user.id
        user_profile_ds=UserProfile.objects.filter(auth_user_id=user_id)
        print("Uer profile object",picture)
        if user_profile_ds:
            user_profile_obj=user_profile_ds.get()
            user_profile_obj.mobile=mobile
            user_profile_obj.prefix=prefix
            user_profile_obj.picture=picture
            user_profile_obj.save()

        return redirect('/home')

    def invite(request):
        email=request.POST.get('email')
        message=request.POST.get('message')
        user_id=request.user.id
        user_name=request.user.first_name+" "+request.user.last_name
        accepted_invite_ds=Invite.objects.filter(user_id=user_id,status="accepted")

        if len(accepted_invite_ds) == 2:
            messages.error(request, 'You already have two friends.')

            return redirect('/home')

        user_obj_ds=User.objects.filter(email=email)

        if user_obj_ds:
            messages.error(request, 'User already exists with this email .')

            return redirect("/home")

        invite_ds=Invite.objects.filter(email=email)

        if not invite_ds:
            invite_obj=Invite.objects.create(user_id=user_id,email=email,created_on=timezone.now(),created_by=user_name)
            invite_id=invite_obj.id
            accept_url=settings.SITE_URL+"/invite_ack/%s?referer_id=%s"%(invite_id,user_id)

            mail = Mailer()
            mail.send_messages(subject="Invite - Formula 50 ",
                               template='invite_email_template.html',
                               context={"content": message, "url": accept_url},
                               to_emails=[email]
                               )
        else:
            messages.error(request, 'Already invited.')
        return redirect('/home')

    def update_invite_status(request,invite_id):
        referer_id = request.GET.get('referer_id')

        accepted_invite_ds=Invite.objects.filter(user_id=referer_id,status='accepted')

        if len(accepted_invite_ds) == 2:
            return HttpResponseNotFound("Invite expired or not exists")

        invite_ds = Invite.objects.filter(id=invite_id)
        if invite_ds:
            invite_obj=invite_ds.get()
            invite_obj.status="accepted"
            invite_obj.save()

            # Redirect to signup page

            template = loader.get_template('login/signup_page.html')
            context = {
                "email": invite_obj.email,
                "referer_id": invite_obj.user_id
            }
            return HttpResponse(template.render(context, request))

        else:
            return HttpResponseNotFound("Invite expired or not exists")






