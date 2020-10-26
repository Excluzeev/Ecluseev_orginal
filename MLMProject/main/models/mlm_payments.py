from django.db import  models
from django.contrib.auth.models import User
from main.models.mlm_base_model import BaseModel
from django.utils.translation import gettext_lazy as _

class Payment(BaseModel):

    class PaymentStatus(models.TextChoices):
        NOTPAID = 'notpaid', _('Not Paid'),
        PAID = 'paid', _('Paid'),

    user=models.ForeignKey(User,on_delete=models.CASCADE,db_column="user_id")
    course=models.IntegerField(default=0)
    status=models.CharField(max_length=20,choices=PaymentStatus.choices,default=PaymentStatus.NOTPAID)

    class Meta:
        managed = True
        db_table = 'mlm_payment'