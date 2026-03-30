from django.db import models

class Promotion(models.Model):
    code = models.CharField(max_length=50, unique=True)
    title = models.CharField(max_length=255)
    description = models.TextField()
    date_range = models.CharField(max_length=255)

    def __str__(self):
        return f"{self.title} ({self.code})"
