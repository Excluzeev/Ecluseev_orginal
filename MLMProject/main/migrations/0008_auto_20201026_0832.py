# Generated by Django 3.1.2 on 2020-10-26 08:32

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('main', '0007_auto_20201026_0457'),
    ]

    operations = [
        migrations.RemoveField(
            model_name='userhierarchy',
            name='role',
        ),
        migrations.AddField(
            model_name='userhierarchy',
            name='course',
            field=models.IntegerField(default=0),
        ),
    ]
