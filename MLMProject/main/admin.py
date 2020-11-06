from django.contrib import admin

# Register your models here.
from main.models.mlm_invite import Invite

class InviteDT(admin.ModelAdmin):
    list_display = ('id','email','status','user')

admin.site.register(Invite,InviteDT)

