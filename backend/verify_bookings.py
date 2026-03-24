import os
import django
import json
import traceback

os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'core.settings')
django.setup()

from django.test import Client
from users.models import User
from bookings.models import Booking

def run_verification():
    try:
        try:
            user = User.objects.get(email='test@example.com')
        except User.DoesNotExist:
            user = User.objects.create_user(email='test@example.com', username='testuser', password='password123')
        
        client = Client()
        client.force_login(user)

        print("--- Testing Add to Cart ---")
        payload = {
            "booking_type": "TRAIN_TICKET",
            "price_rp": 150000,
            "from": "Jakarta",
            "to": "Bandung",
            "date": "2024-05-20",
            "departure": "08:00 AM",
            "arrive": "11:00 AM",
            "train": "Argo Parahyangan",
            "carriage": "EKS-1",
            "seat": "12A",
            "class_label": "Executive"
        }
        response = client.post('/api/bookings/cart/add/', data=json.dumps(payload), content_type='application/json')
        print(f"Add to Cart Status: {response.status_code}")
        print(f"Response: {response.json()}")
        booking_id = response.json()['id']

        print("\n--- Testing List Cart ---")
        response = client.get('/api/bookings/cart/')
        print(f"List Cart Status: {response.status_code}")
        if response.status_code == 200 and len(response.json()) > 0:
            print(f"First Item: {json.dumps(response.json()[0], indent=2)}")
        else:
            print("Cart is empty or error occurred")

        print("\n--- Testing Checkout Details ---")
        response = client.get(f'/api/bookings/{booking_id}/checkout/')
        print(f"Checkout Status: {response.status_code}")
        print(f"Details: {json.dumps(response.json(), indent=2)}")

        print("\n--- Testing Payment ---")
        response = client.post(f'/api/bookings/{booking_id}/pay/')
        print(f"Payment Status: {response.status_code}")
        print(f"Response: {response.json()}")

        print("\n--- Verification Complete ---")
    except Exception as e:
        print(f"An error occurred: {e}")
        traceback.print_exc()

if __name__ == "__main__":
    run_verification()
