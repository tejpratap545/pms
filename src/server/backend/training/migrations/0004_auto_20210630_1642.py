# Generated by Django 3.2.3 on 2021-06-30 11:12

from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        ('appraisals', '0004_alter_appraisal_status'),
        ('training', '0003_departmentalcorevalue_departmentalgoal'),
    ]

    operations = [
        migrations.AlterField(
            model_name='departmentalcorevalue',
            name='appraisal',
            field=models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='appraisals.overallappraisal'),
        ),
        migrations.AlterField(
            model_name='departmentalgoal',
            name='appraisal',
            field=models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='appraisals.overallappraisal'),
        ),
    ]