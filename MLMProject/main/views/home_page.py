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
from helper import get_user_hierarchy,get_paid_child,get_root_node,get_depth,get_all_child

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

                user_data.append({"id": user_obj.id,"email": user_obj.email, "first_name": user_obj.first_name, "last_name": user_obj.last_name, "payment_status": user_profile_obj.payment_status, "date_joined": user_obj.date_joined,"course": user_profile_obj.course})

            context = {
                "all_users": user_data,
            }

            return HttpResponse(template.render(context, request))

    def get_tree(request,user_id):
        user_ha_list=[]

        user_profile_obj_ds = UserProfile.objects.filter(auth_user_id=user_id)
        user_profile_obj = user_profile_obj_ds.get()
        course=user_profile_obj.course
        course=0
        depth=get_depth(user_id,course,0)
        get_user_hierarchy(user_id, 0, user_ha_list,course,depth)

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
            user_profile_obj = user_profile_obj_ds.get()
            user_ha_list=[]
            depth = get_depth(user_id, user_profile_obj.course, 0)
            user_role=get_user_hierarchy(request.user.id,0,user_ha_list,user_profile_obj.course,depth)
            print("Ha data",user_role)

            user_profile_obj.designation=user_role
            user_profile_obj.save()

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

        for user_id in user_ids:

            user_profile_obj_ds = UserProfile.objects.filter(auth_user_id=user_id)
            user_profile_obj = user_profile_obj_ds.get()

            if user_profile_obj.payment_status == "paid":
                continue

            user_profile_obj.payment_status=status
            user_profile_obj.save()

            if status == 'paid':

                root_node = get_root_node(user_id, 0)
                no_of_paid_users=get_paid_child(root_node.id,0,user_profile_obj.course)
                print("USer_id", user_id, no_of_paid_users)
                if no_of_paid_users == 15:  # if all the child users paid, then move to course 1
                    print("Going to update",user_id)
                    root_profile_obj=UserProfile.objects.get(auth_user_id=root_node.id)
                    root_profile_obj.course=root_profile_obj.course+1
                    root_profile_obj.save()


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






