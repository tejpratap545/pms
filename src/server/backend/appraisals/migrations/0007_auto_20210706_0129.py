# Generated by Django 3.2.3 on 2021-07-05 19:59

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('appraisals', '0006_alter_appraisal_status'),
    ]

    operations = [
        migrations.RenameField(
            model_name='appraisal',
            old_name='stage3_employee_comment',
            new_name='core_value_employee_comment',
        ),
        migrations.RenameField(
            model_name='appraisal',
            old_name='stage3_manager_comment',
            new_name='core_value_hod_comment',
        ),
        migrations.RenameField(
            model_name='appraisal',
            old_name='stage3_rejection_comment',
            new_name='core_value_manager_comment',
        ),
        migrations.AddField(
            model_name='appraisal',
            name='core_value_employee_rating',
            field=models.IntegerField(blank=True, choices=[(1, '1 - Major Improvement Needed'), (2, '2 - Needs Improvement'), (3, '3 - Meets Expectations'), (4, '4 - Exceeds Expectations'), (5, '5 - Far Exceed Expectations')], null=True),
        ),
        migrations.AddField(
            model_name='appraisal',
            name='core_value_hod_rating',
            field=models.IntegerField(blank=True, choices=[(1, '1 - Major Improvement Needed'), (2, '2 - Needs Improvement'), (3, '3 - Meets Expectations'), (4, '4 - Exceeds Expectations'), (5, '5 - Far Exceed Expectations')], null=True),
        ),
        migrations.AddField(
            model_name='appraisal',
            name='core_value_manager_rating',
            field=models.IntegerField(blank=True, choices=[(1, '1 - Major Improvement Needed'), (2, '2 - Needs Improvement'), (3, '3 - Meets Expectations'), (4, '4 - Exceeds Expectations'), (5, '5 - Far Exceed Expectations')], null=True),
        ),
        migrations.AddField(
            model_name='appraisal',
            name='stage0_employee_comment',
            field=models.TextField(blank=True, null=True),
        ),
        migrations.AddField(
            model_name='appraisal',
            name='stage0_manager_comment',
            field=models.TextField(blank=True, null=True),
        ),
        migrations.AddField(
            model_name='appraisal',
            name='stage0_rejection_comment',
            field=models.TextField(blank=True, null=True),
        ),
        migrations.AlterField(
            model_name='appraisal',
            name='status',
            field=models.IntegerField(blank=True, choices=[(0, 'STAGE 0: Employee Goal settings stage'), (1, 'STAGE 0: Manager Goal apprave stage'), (2, 'STAGE 1: Employee mid year review stage'), (3, 'STAGE 1: Employee mid year submit stage'), (4, 'STAGE 1: Manager mid year review stage'), (5, 'STAGE 1: Manager mid year approve stage'), (5, 'STAGE 2: Employee end year review stage'), (6, 'STAGE 2: Employee end year submit stage'), (7, 'STAGE 2: Manager end year review stage'), (8, 'STAGE 2: Manager end year approve stage'), (9, 'STAGE 2: Manager Approved end year review'), (10, 'STAGE 2: hod end year approve stage'), (11, 'STAGE 2: hod approved year approve stage')], default=0),
        ),
    ]