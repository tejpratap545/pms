# Generated by Django 3.2.3 on 2021-06-30 11:06

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('appraisals', '0003_alter_appraisal_status'),
    ]

    operations = [
        migrations.AlterField(
            model_name='appraisal',
            name='status',
            field=models.IntegerField(blank=True, choices=[(0, 'STAGE 1: Employee Goal settings stage'), (1, 'STAGE 1: Manager Goal apprave stage'), (2, 'STAGE 1: Manager Approved the goal'), (3, 'STAGE 2: Employee mid year review stage'), (4, 'STAGE 2: Employee mid year submit stage'), (5, 'STAGE 2: Manager mid year approve stage'), (6, 'STAGE 2: Manager Approved mid year review'), (7, 'STAGE 3: Employee end year review stage'), (8, 'STAGE 3: Employee end year submit stage'), (9, 'STAGE 3: Manager end year approve stage'), (10, 'STAGE 3: Manager Approved end year review'), (11, 'STAGE 3: hod end year approve stage'), (12, 'STAGE 3: hod approved year approve stage')], default=0),
        ),
    ]
