import os
import django
import json
import traceback

os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'core.settings')
django.setup()

from django.test import Client
from users.models import User
from bookings.models import Booking

def run_simple_test():
    try:
        user, created = User.objects.get_or_create(email='test@example.com', defaults={'username':'testuser'})
        if created:
            user.set_password('password123')
            user.save()
            
        client = Client()
        client.force_login(user)

        print("Deleting existing bookings for clean test...")
        Booking.objects.filter(user=user).delete()

        print("Creating booking manually...")
        booking = Booking.objects.create(
            user=user,
            booking_type='TRAIN_TICKET',
            price_rp=100000,
            from_location='Jakarta',
            to_location='Bandung',
            status='IN_CART',
            class_label='Economy'
        )
        print(f"Booking ID: {booking.id}")

        print("\nListing cart via API...")
        response = client.get('/api/bookings/cart/')
        print(f"Status: {response.status_code}")
        if response.status_code == 200:
            data = response.json()
            print(f"Data: {json.dumps(data, indent=2)}")
            if len(data) > 0:
                print("Cart structure is valid.")
        else:
            print(f"Error Body: {response.content.decode()}")

        print("\nVerification Complete")
    except Exception as e:
        print(f"Error outside request: {e}")
        traceback.print_exc()

if __name__ == "__main__":
    run_simple_test()
