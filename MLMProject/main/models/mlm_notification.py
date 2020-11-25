from django.db import  models
from django.contrib.auth.models import User
from main.models.mlm_base_model import BaseModel
from django.utils.translation import gettext_lazy as _

class Notification(BaseModel):

    class Status(models.TextChoices):
        READ = 'read', _('Read'),
        UNREAD = 'unread', _('Unread'),

    class Tag(models.TextChoices):
        INFO = 'info', _('info'),
        IMPORTANT = 'important', _('important'),

    from_user=models.ForeignKey(User,on_delete=models.CASCADE,db_column="from_user_id",related_name='from_user',null=True)
    to_user=models.ForeignKey(User,on_delete=models.CASCADE,db_column="to_user_id",related_name='to_user',null=True)
    is_to_admin=models.BooleanField(default=False)
    subject=models.CharField(max_length=150)
    tag=models.CharField(max_length=30,choices=Tag.choices,default=Tag.INFO)
    message=models.TextField()
    status=models.CharField(max_length=20,choices=Status.choices,default=Status.UNREAD)
    created_on=models.DateTimeField(auto_now_add=True)

    class Meta:
        managed = True
        db_table = 'mlm_notification'