from rest_framework import viewsets, status, decorators
from rest_framework.response import Response
from rest_framework.permissions import IsAuthenticated, AllowAny
from .models import Booking, PurchaseItem
from .serializers import CartTicketSerializer, CheckoutDetailsSerializer

class BookingViewSet(viewsets.ModelViewSet):
    permission_classes = [IsAuthenticated]
    queryset = Booking.objects.all()

    def get_queryset(self):
        return self.queryset.filter(user=self.request.user)

    @decorators.action(detail=False, methods=['get'])
    def cart(self, request):
        cart_items = self.get_queryset().filter(status='IN_CART')
        serializer = CartTicketSerializer(cart_items, many=True)
        return Response(serializer.data)

    @decorators.action(detail=False, methods=['post'], url_path='cart/add')
    def add_to_cart(self, request):
        # In a real app, we'd validate against real travel data
        # Here we'll just create a booking from the provided data
        
        booking = Booking.objects.create(
            user=request.user,
            status='IN_CART',
            booking_type=request.data.get('booking_type', 'TRAIN_TICKET'),
            price_rp=request.data.get('price_rp', 0),
            from_location=request.data.get('from'),
            to_location=request.data.get('to'),
            date=request.data.get('date'),
            departure_time=request.data.get('departure'),
            arrival_time=request.data.get('arrive'),
            train_number=request.data.get('train'),
            carriage=request.data.get('carriage'),
            seat_number=request.data.get('seat'),
            class_label=request.data.get('class_label'),
            image_url=request.data.get('image_url'),
            stay_date=request.data.get('stay_date'),
            stay_duration=request.data.get('stay_duration'),
            bed_type=request.data.get('bed_type'),
            location_name=request.data.get('location'),
        )
        
        # Add default purchase items for price breakdown
        PurchaseItem.objects.create(booking=booking, label='Ticket Price', amount_rp=booking.price_rp)
        PurchaseItem.objects.create(booking=booking, label='Service Fee', amount_rp=25000)
        
        return Response({"message": "Added to cart", "id": booking.id}, status=status.HTTP_201_CREATED)

    @decorators.action(detail=True, methods=['get'])
    def checkout(self, request, pk=None):
        booking = self.get_object()
        print(f"DEBUG: Checkout for booking: {booking}")
        serializer = CheckoutDetailsSerializer(booking)
        try:
            data = serializer.data
            return Response(data)
        except Exception as e:
            print(f"DEBUG: Serializer error: {e}")
            import traceback
            traceback.print_exc()
            raise

    @decorators.action(detail=True, methods=['post'])
    def pay(self, request, pk=None):
        booking = self.get_object()
        if booking.status == 'PAID':
            return Response({"error": "Already paid"}, status=status.HTTP_400_BAD_REQUEST)
        
        booking.status = 'PAID'
        booking.save()
        return Response({"message": "Payment successful", "status": booking.status})
