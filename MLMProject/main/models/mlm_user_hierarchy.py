from django.db import  models
from django.contrib.auth.models import User
from main.models.mlm_base_model import BaseModel
from django.utils.translation import gettext_lazy as _

class UserHierarchy(BaseModel):

    user=models.ForeignKey(User,on_delete=models.CASCADE,db_column="user_id",related_name="user_hierarchy_user")
    parent=models.ForeignKey(User,on_delete=models.CASCADE,db_column="parent_user_id",related_name="user_hierarchy_parent_user")
    role=models.CharField(max_length=30,null=True) # User's designation, it will vary based on structure

    class Meta:
        managed = True
        db_table = 'mlm_user_hierarchy'