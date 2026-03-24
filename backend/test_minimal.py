import os
import django
import json

os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'core.settings')
django.setup()

from django.test import Client

client = Client()

print("--- Testing Metadata ---")
response = client.get('/api/support/metadata/')
print(f"Status: {response.status_code}")
try:
    print(f"Content: {response.content.decode()}")
except:
    print(f"Raw Content: {response.content}")

print("\n--- Testing FAQs ---")
response = client.get('/api/support/faqs/')
print(f"Status: {response.status_code}")
try:
    print(f"Content: {response.content.decode()}")
except:
    print(f"Raw Content: {response.content}")
