import os
import django
import json
import traceback

os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'core.settings')
django.setup()

from bookings.models import Booking
from bookings.serializers import CartTicketSerializer, CheckoutDetailsSerializer

def debug_serializer():
    try:
        b = Booking.objects.first()
        print(f"DEBUG: Booking instance: {b}")
        if b:
            print(f"DEBUG: booking_type: {b.booking_type}")
            # print(f"DEBUG: has get_booking_type_display: {hasattr(b, 'get_booking_type_display')}")
            s = CartTicketSerializer(b)
            print("DEBUG: Serializer initialized")
            print(f"DEBUG: Serializer fields: {list(s.fields.keys())}")
            data = s.data
            print("DEBUG: Serializer data success")
            print(json.dumps(data, indent=2))
        else:
            print("DEBUG: No bookings found")
    except Exception as e:
        print(f"DEBUG: ERROR: {e}")
        traceback.print_exc()

if __name__ == "__main__":
    debug_serializer()
