from django.db import  models
from django.contrib.auth.models import User
from main.models.mlm_base_model import BaseModel
from django.utils.translation import gettext_lazy as _
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
    picture = models.ImageField(blank=True, null=True)
    designation = models.CharField(max_length=60, choices=Designation.choices,default=Designation.STUDENT)
    prefix = models.CharField(max_length=20, null=True, blank=True)
    auth_user=models.ForeignKey(User,on_delete=models.CASCADE,db_column="user_id")
    payment_status=models.CharField(max_length=20,choices=PaymentStatus.choices,default=PaymentStatus.NOTPAID)

    class Meta:
        managed = True
        db_table = 'mlm_user_profile'