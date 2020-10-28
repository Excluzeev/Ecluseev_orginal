from django.db import  models
from django.contrib.auth.models import User
from main.models.mlm_base_model import BaseModel
from django.utils.translation import gettext_lazy as _

class Group(BaseModel):

    user=models.ForeignKey(User,on_delete=models.CASCADE,db_column="user_id")

    class Meta:
        managed = True
        db_table = 'mlm_group'