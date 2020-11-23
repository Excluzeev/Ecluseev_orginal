from django.db import  models
from django.contrib.auth.models import User
from main.models.mlm_base_model import BaseModel
from django.utils.translation import gettext_lazy as _
import os
from django.db.models import JSONField
def update_file_name(instance, filename):
    path = "user_profile/"

    # Unique identifier
    format="%s_%s"%(instance.id,filename)

    print("Debug",format)
    #format = instance.userid + instance.transaction_uuid + instance.file_extension
    return os.path.join(path, format)


class UserProfile(BaseModel):
    class PaymentStatus(models.TextChoices):
        NOTPAID = 'notpaid', _('Not Paid'),
        PAID = 'paid', _('Paid'),

    class Designation(models.TextChoices):
        STUDENT = 'student', _('Student'),
        SCHOLAR = 'scholar', _('Scholar'),
        PREFECT = 'prefect', _('Prefect'),
        BURSAR = 'bursar', _('Bursar'),


    mobile = models.CharField(max_length=20, null=True, blank=True)
    picture = models.ImageField(blank=True, null=True,upload_to=update_file_name)
    designation = models.CharField(max_length=60, choices=Designation.choices,default=Designation.STUDENT)
    prefix = models.CharField(max_length=20, null=True, blank=True)
    auth_user=models.OneToOneField(User,on_delete=models.CASCADE,db_column="user_id")
    course=models.IntegerField(default=0)
    group=models.IntegerField(default=0)
    payment_status=models.CharField(max_length=20,choices=PaymentStatus.choices,default=PaymentStatus.NOTPAID)
    hr_tree=JSONField(null=True)
    is_manual_signup = models.BooleanField(default=False)
    class Meta:
        managed = True
        db_table = 'mlm_user_profile'