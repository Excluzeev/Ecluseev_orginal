from django.db import  models
from django.utils import timezone
class BaseModel(models.Model):
    created_on = models.DateTimeField(blank=True, null=True)
    last_updated_on = models.DateTimeField(blank=True, null=True)
    created_by = models.CharField(max_length=60, blank=True, null=True)
    last_updated_by = models.CharField(max_length=60, blank=True, null=True)

    class Meta:
        abstract = True