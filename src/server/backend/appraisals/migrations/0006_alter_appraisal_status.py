# Generated by Django 3.2.3 on 2021-07-04 18:50

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('appraisals', '0005_auto_20210702_2227'),
    ]

    operations = [
        migrations.AlterField(
            model_name='appraisal',
            name='status',
            field=models.IntegerField(blank=True, choices=[(0, 'STAGE 0: Employee Goal settings stage'), (1, 'STAGE 0: Manager Goal apprave stage'), (2, 'STAGE 0: Manager Approved the goal'), (3, 'STAGE 1: Employee mid year review stage'), (4, 'STAGE 1: Employee mid year submit stage'), (5, 'STAGE 1: Manager mid year approve stage'), (6, 'STAGE 1: Manager Approved mid year review'), (7, 'STAGE 2: Employee end year review stage'), (8, 'STAGE 2: Employee end year submit stage'), (9, 'STAGE 2: Manager end year approve stage'), (10, 'STAGE 2: Manager Approved end year review'), (11, 'STAGE 2: hod end year approve stage'), (12, 'STAGE 2: hod approved year approve stage')], default=0),
        ),
    ]
