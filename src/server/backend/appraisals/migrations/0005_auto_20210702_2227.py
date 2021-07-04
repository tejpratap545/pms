# Generated by Django 3.2.3 on 2021-07-02 16:57

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('appraisals', '0004_alter_appraisal_status'),
    ]

    operations = [
        migrations.AddField(
            model_name='appraisal',
            name='hod_comment',
            field=models.TextField(blank=True, null=True),
        ),
        migrations.AddField(
            model_name='appraisal',
            name='hod_rating',
            field=models.IntegerField(blank=True, choices=[(1, '1 - Major Improvement Needed'), (2, '2 - Needs Improvement'), (3, '3 - Meets Expectations'), (4, '4 - Exceeds Expectations'), (5, '5 - Far Exceed Expectations')], null=True),
        ),
    ]