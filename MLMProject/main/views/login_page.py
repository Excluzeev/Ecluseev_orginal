from django.http import HttpResponse
from django.template import loader
from django.views.generic import View
from django.contrib.auth import authenticate, login,logout
from django.shortcuts import redirect
from django.contrib.auth.forms import UserCreationForm
from django.shortcuts import render, redirect
from django.contrib.auth.models import User
from main.models.mlm_user_profile import UserProfile
from main.models.mlm_user_hierarchy import UserHierarchy

class LoginPage(View):

    def login(request):
        print("method",request.method)
        if request.method == 'GET':
            template = loader.get_template('login/login_page.html')
            context = {
                "error": None
            }
            return HttpResponse(template.render(context, request))

        elif request.method == 'POST':
            username = request.POST['username']
            password = request.POST['password']
            user = authenticate(request, username=username, password=password)
            print("USer",user)
            if user is not None:
                login(request, user)
                if user.is_superuser:
                    return redirect('/dashboard')

                return redirect('/home')

            else:
                template = loader.get_template('login/login_page.html')
                context = {
                    "error": {"message": "Invalid user credentials"}
                }
                return HttpResponse(template.render(context, request))

    def signup(request):
        template = loader.get_template('login/signup_page.html')

        if request.method == 'POST':
            username=request.POST.get("email")
            referer_id=request.POST.get("referer_id")

            password1=request.POST.get("password1")
            password2=request.POST.get("password2")
            first_name=request.POST.get("first_name")
            last_name=request.POST.get("last_name")
            email=username

            if password1 != password2:
                print("Password didn't match")
                context = {
                    'error': {"message": "Passwords didn't match"}
                }
                return HttpResponse(template.render(context, request))

            user_obj_ds=User.objects.filter(email=email)
            if user_obj_ds:
                context = {
                    'error': {"message": "Email already exists!"}
                }
                return HttpResponse(template.render(context, request))

            new_user = User.objects.create_user(username, email, password1)
            new_user.is_active = True
            new_user.first_name = first_name
            new_user.last_name = last_name
            new_user.save()

            UserProfile.objects.create(auth_user_id=new_user.id)

            # if a signup for has referer id, then need to link the user with his appropriate referer
            if referer_id:
                UserHierarchy.objects.create(user_id=new_user.id,parent_id=referer_id)


            user = authenticate(username=username, password=password1)
            login(request, user)
            return redirect('/home')

        return render(request, 'login/signup_page.html', {'error': None})



    def fwpassword(request):
        pass

    def logout(request):
        logout(request)
        return redirect('/home')



