# Generated by Django 3.1.2 on 2020-10-24 05:22

from django.conf import settings
from django.db import migrations, models
import django.db.models.deletion
import main.models.mlm_user_profile


class Migration(migrations.Migration):

    dependencies = [
        migrations.swappable_dependency(settings.AUTH_USER_MODEL),
        ('main', '0002_auto_20201022_1123'),
    ]

    operations = [
        migrations.AddField(
            model_name='userprofile',
            name='course',
            field=models.IntegerField(default=0),
        ),
        migrations.AddField(
            model_name='userprofile',
            name='group',
            field=models.IntegerField(default=0),
        ),
        migrations.AlterField(
            model_name='userprofile',
            name='auth_user',
            field=models.OneToOneField(db_column='user_id', on_delete=django.db.models.deletion.CASCADE, to=settings.AUTH_USER_MODEL),
        ),
        migrations.AlterField(
            model_name='userprofile',
            name='designation',
            field=models.CharField(choices=[('student', 'Student'), ('scholar', 'Scholar'), ('prefect', 'Prefect'), ('bursar', 'Bursar')], default='student', max_length=60),
        ),
        migrations.AlterField(
            model_name='userprofile',
            name='picture',
            field=models.ImageField(blank=True, null=True, upload_to=main.models.mlm_user_profile.update_file_name),
        ),
    ]