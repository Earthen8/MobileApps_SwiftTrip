import os
import django

os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'core.settings')
django.setup()

from promotions.models import Promotion

promotions = [
    {
        'code': 'promo_1',
        'title': 'Family Discount',
        'date_range': '12 Feb 2024 - 12 Mar 2025',
        'description': 'Discount 10% with minimum Rp 1.000.000 purchases',
    },
    {
        'code': 'promo_2',
        'title': 'Student Getaway',
        'date_range': '01 Jan 2024 - 31 Dec 2024',
        'description': 'Discount 15% with valid student ID card',
    },
    {
        'code': 'promo_3',
        'title': 'Weekend Flash Sale',
        'date_range': 'Every Saturday - Sunday',
        'description': 'Cashback Rp 50.000 with no minimum purchase',
    },
]

# Wipe existing data to avoid conflicts with new 'code' unique requirement
Promotion.objects.all().delete()

for p in promotions:
    Promotion.objects.get_or_create(**p)

print("Promotions seeded successfully with codes!")
