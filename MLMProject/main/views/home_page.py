from django.http import HttpResponse
from django.template import loader
from django.views.generic import View
from django.contrib.auth import authenticate, login
from django.shortcuts import redirect
from main.models.mlm_invite import  Invite
from main.models.mlm_user_profile import UserProfile
from main.models.mlm_user_hierarchy import UserHierarchy
from mailer import Mailer
from main.models.mlm_invite import Invite
from django.utils import  timezone
from django.http import HttpResponseNotFound,JsonResponse

class HomePage(View):

    def index(request):
        if not request.user.is_authenticated:
            return redirect('/login')
        else:
            template = loader.get_template('home/home_page.html')
            ds=Invite.objects.filter(user_id=request.user.id).all()
            context = {
                "invites": ds
            }
            return HttpResponse(template.render(context, request))

    def invite(request):
        email=request.POST.get('email')
        message=request.POST.get('message')
        user_id=request.user.id
        user_name=request.user.first_name+" "+request.user.last_name
        invite_ds=Invite.objects.filter(email=email)

        if not invite_ds:
            Invite.objects.create(user_id=user_id,email=email,created_on=timezone.now(),created_by=user_name)
            mail = Mailer()
            mail.send_messages(subject="Invite - Formula 50 ",
                               template='invite_email_template.html',
                               context={"content": message},
                               to_emails=[email]
                               )

        return redirect('/home')

    def update_invite_status(request):
        invite_id = request.POST.get('invite_id')
        invite_ds = Invite.objects.filter(id=invite_id)
        if invite_ds:
            invite_obj=invite_ds.get()
            invite_obj.status="accepted"
            invite_obj.save()

            return redirect('/home')

        else:
            return HttpResponseNotFound("Invite expired or not exists")






