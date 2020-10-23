
from django.urls import path, include
from main.views.login_page import LoginPage
from main.views.home_page import   HomePage
urlpatterns = [
    path('', HomePage.index),
    path('home', HomePage.index),
    path('login',LoginPage.login),
    path('logout', LoginPage.logout),
    path('invite', HomePage.invite),
    path('invite_ack/<int:invite_id>', HomePage.update_invite_status),
]