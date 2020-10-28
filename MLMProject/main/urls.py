
from django.urls import path, include
from main.views.login_page import LoginPage
from main.views.home_page import   HomePage
urlpatterns = [
    path('', HomePage.index),
    path('home', HomePage.index),
    path('login',LoginPage.login),
    path('signup', LoginPage.signup),
    path('logout', LoginPage.logout),
    path('update_my_profile',HomePage.update_my_profile),
    path('update_payment_status', HomePage.update_payment_status),
    path('invite', HomePage.invite),
    path('add_user', HomePage.add_user),
    path('remove_user', HomePage.remove_user),
    path('dashboard', HomePage.dashboard),
    path('get_tree/<int:user_id>', HomePage.get_tree),

    path('invite_ack/<int:invite_id>', HomePage.update_invite_status),
]