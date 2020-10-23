from django.http import HttpResponse
from django.template import loader
from django.views.generic import View
from django.contrib.auth import authenticate, login,logout
from django.shortcuts import redirect

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
                return redirect('/home')

            else:
                template = loader.get_template('login/login_page.html')
                context = {
                    "error": {"message": "Invalid user credentials"}
                }
                return HttpResponse(template.render(context, request))

    def signup(request):
        pass

    def fwpassword(request):
        pass

    def logout(request):
        logout(request)
        return redirect('/home')



