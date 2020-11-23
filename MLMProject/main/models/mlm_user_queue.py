from django.db import  models
from django.contrib.auth.models import User
from main.models.mlm_base_model import BaseModel
from django.utils.translation import gettext_lazy as _
import os
from django.db.models import JSONField
from main.models.mlm_user_profile import UserProfile
class UserQueue(BaseModel):

    user_profile=models.OneToOneField(UserProfile,on_delete=models.CASCADE)
    is_mapped=models.BooleanField(default=False)

    class Meta:
        managed = True
        db_table = 'mlm_user_queue'