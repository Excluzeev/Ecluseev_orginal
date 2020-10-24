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

class AdminPage(View):

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

