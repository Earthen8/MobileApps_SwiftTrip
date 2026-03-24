import random
from django.core.management.base import BaseCommand
from django.contrib.auth import get_user_model
from travel_data.models import Destination, Schedule

User = get_user_model()

class Command(BaseCommand):
    help = 'Seeds Destination (Villas/Hotels) and Schedule (User Itinerary) data'

    def handle(self, *args, **options):
        # 1. Fetch or create a default user (Must use EMAIL, not username)
        user, _ = User.objects.get_or_create(
            email='admin@swifttrip.com',
            defaults={
                'first_name': 'Admin',
                'last_name': 'User',
                'is_staff': True,
                'is_superuser': True
            }
        )
        if not user.password:
            user.set_password('admin123')
            user.save()

        # 2. Seed Destination Model
        destinations = [
            {
                'name': 'Alila Villas Uluwatu',
                'category': 'Villa',
                'rating': 4.9,
                'price': 15000000,
                'image_url': 'https://images.unsplash.com/photo-1543489816-c87b0f7f287a?w=500',
                'description': 'Contemporary Bali villas with private pools.',
                'is_hot': True
            },
            {
                'name': 'Mandapa, Ritz-Carlton',
                'category': 'Hotel',
                'rating': 4.8,
                'price': 12000000,
                'image_url': 'https://images.unsplash.com/photo-1544551763-46a013bb70d5?w=500',
                'description': 'A sanctuary for the senses along the Ayung River.',
                'has_discount': True
            }
        ]

        for d in destinations:
            Destination.objects.update_or_create(
                name=d['name'],
                defaults=d
            )

        # 3. Seed Schedule Model (Note: time is a CharField in your model)
        itineraries = [
            {
                'title': 'Trip to Ngawi Barat',
                'time': '10:00 AM',
                'image_url': 'https://images.unsplash.com/photo-1464822759023-fed622ff2c3b?w=500'
            },
            {
                'title': 'Solo Exploration',
                'time': '02:30 PM',
                'image_url': 'https://images.unsplash.com/photo-1518709268805-4e9042af9f23?w=500'
            }
        ]

        for item in itineraries:
            Schedule.objects.update_or_create(
                user=user,
                title=item['title'],
                defaults=item
            )

        self.stdout.write(self.style.SUCCESS('Successfully seeded Destination and Itinerary data.'))
