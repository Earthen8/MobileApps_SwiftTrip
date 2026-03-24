import os
import django
import json
import traceback

os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'core.settings')
django.setup()

from django.test import Client
from users.models import User
from support.models import FAQ, SupportTicket, TicketReply

def run_verification():
    try:
        # 1. Setup User
        try:
            user = User.objects.get(email='test_support@example.com')
        except User.DoesNotExist:
            user = User.objects.create_user(email='test_support@example.com', password='password123', first_name='Support', last_name='User')
        
        client = Client()
        
        # login to get token
        login_payload = {
            "email": "test_support@example.com",
            "password": "password123"
        }
        login_response = client.post('/api/auth/login/', data=json.dumps(login_payload), content_type='application/json')
        if login_response.status_code != 200:
            print(f"Login failed: {login_response.json()}")
            return
        
        token = login_response.json()['access']
        auth_headers = {'HTTP_AUTHORIZATION': f'Bearer {token}'}
        print("Logged in successfully and obtained JWT token")

        # 2. Setup initial FAQ
        if FAQ.objects.count() == 0:
            FAQ.objects.create(question="How to refund?", answer="Contact support via ticket.")
            print("Created sample FAQ")

        print("\n--- Testing Metadata ---")
        response = client.get('/api/support/metadata/')
        print(f"Metadata Status: {response.status_code}")
        print(f"Data: {json.dumps(response.json(), indent=2)}")

        print("\n--- Testing FAQs ---")
        response = client.get('/api/support/faqs/')
        print(f"FAQs Status: {response.status_code}")
        print(f"Data: {json.dumps(response.json(), indent=2)}")

        print("\n--- Testing Post Ticket (Add Request) ---")
        payload = {
            "p": "Bugs",
            "l": "Home",
            "pt": "Public",
            "h": "Bug in main screen",
            "s": "The app crashes when I tap the logo."
        }
        # Wait, I used short keys in my thinking but I should use the real ones.
        payload = {
            "problem_type": "Bugs",
            "location": "Home",
            "publish_type": "Public",
            "header": "Bug in main screen",
            "statement": "The app crashes when I tap the logo."
        }
        response = client.post('/api/support/tickets/', data=json.dumps(payload), content_type='application/json', **auth_headers)
        print(f"Post Ticket Status: {response.status_code}")
        ticket_data = response.json()
        if response.status_code != 201:
            print(f"Error Response: {json.dumps(ticket_data, indent=2)}")
            return
        
        print(f"Ticket Response: {json.dumps(ticket_data, indent=2)}")
        ticket_id = ticket_data['id']

        print("\n--- Testing List My Tickets ---")
        response = client.get('/api/support/tickets/', **auth_headers)
        print(f"List Tickets Status: {response.status_code}")
        print(f"Count: {len(response.json())}")

        print("\n--- Testing List Public Tickets (Recent Questions) ---")
        response = client.get('/api/support/tickets/public/', **auth_headers)
        print(f"Public Tickets Status: {response.status_code}")
        print(f"Count: {len(response.json())}")

        print("\n--- Testing Ticket Thread (Replies) ---")
        response = client.get(f'/api/support/tickets/{ticket_id}/thread/', **auth_headers)
        print(f"Thread Status: {response.status_code}")
        print(f"Replies: {json.dumps(response.json(), indent=2)}")

        print("\n--- Testing Post Reply ---")
        reply_payload = {"body": "We are looking into it."}
        response = client.post(f'/api/support/tickets/{ticket_id}/reply/', data=json.dumps(reply_payload), content_type='application/json', **auth_headers)
        print(f"Post Reply Status: {response.status_code}")
        print(f"Reply Response: {json.dumps(response.json(), indent=2)}")

        print("\n--- Testing Thread After Reply ---")
        response = client.get(f'/api/support/tickets/{ticket_id}/thread/', **auth_headers)
        print(f"Thread Status: {response.status_code}")
        print(f"Replies: {json.dumps(response.json(), indent=2)}")

        print("\n--- Verification Complete ---")
    except Exception as e:
        print(f"An error occurred: {e}")
        traceback.print_exc()

if __name__ == "__main__":
    run_verification()
