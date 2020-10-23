from django.db import  models
from django.contrib.auth.models import User
from main.models.mlm_base_model import BaseModel
from django.utils.translation import gettext_lazy as _

class Invite(BaseModel):
    class Status(models.TextChoices):
        INVITED = 'invited', _('Invited'),
        ACCEPTED = 'accepted', _('Accepted'),

    user=models.ForeignKey(User,on_delete=models.CASCADE,db_column="user_id")
    status=models.CharField(max_length=20,choices=Status.choices,default=Status.INVITED)
    email=models.CharField(max_length=255)

    class Meta:
        managed = True
        db_table = 'mlm_invite'