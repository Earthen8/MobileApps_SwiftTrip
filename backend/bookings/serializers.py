from datetime import date
import random

from rest_framework import serializers
from .models import Booking, PurchaseItem, Destination, Review

class PurchaseItemSerializer(serializers.ModelSerializer):
    amount = serializers.SerializerMethodField()
    label = serializers.CharField()
    is_discount = serializers.BooleanField()

    class Meta:
        model = PurchaseItem
        fields = ['label', 'amount', 'is_discount']
    
    def get_amount(self, obj):
        prefix = "-" if obj.is_discount else ""
        return f"{prefix}Rp {obj.amount_rp:,}"

class DestinationSerializer(serializers.ModelSerializer):
    final_price = serializers.DecimalField(max_digits=12, decimal_places=2, read_only=True)
    is_favorite = serializers.SerializerMethodField()
    review_count = serializers.SerializerMethodField()
    rating = serializers.SerializerMethodField()

    class Meta:
        model = Destination
        fields = [
            'id', 'title', 'category', 'image_url', 'location',
            'rating', 'original_price', 'discount_percentage',
            'description', 'advantages', 'tags', 'section_tag', 'final_price', 'is_favorite',
            'latitude', 'longitude', 'review_count',
        ]

    def get_is_favorite(self, obj):
        request = self.context.get('request')
        if request and request.user.is_authenticated:
            return obj.wishlisted_by.filter(user=request.user).exists()
        return False

    def get_rating(self, obj):
        # Safely get the annotated average rating
        avg = getattr(obj, 'avg_rating', 0.0)
        if not avg or avg == 0:
            # Fallback to premium rating if no reviews exist
            return round(random.Random(obj.id).uniform(4.5, 5.0), 1)
        return round(avg, 1)

    def get_review_count(self, obj):
        if hasattr(obj, 'num_reviews'):
            return obj.num_reviews
        return obj.reviews.count()


class ReviewSerializer(serializers.ModelSerializer):
    username = serializers.CharField(source='user.username', read_only=True)

    class Meta:
        model = Review
        fields = ['id', 'username', 'rating', 'feeling', 'thoughts', 'created_at']
        read_only_fields = ['id', 'username', 'created_at']

class CartTicketSerializer(serializers.ModelSerializer):
    type = serializers.SerializerMethodField()
    booking_id = serializers.CharField(source='id')
    class_label = serializers.CharField()
    price_rp = serializers.IntegerField()
    
    # Transport fields
    from_loc = serializers.CharField(source='from_location', required=False, allow_null=True)
    to_loc = serializers.CharField(source='to_location', required=False, allow_null=True)
    departure = serializers.CharField(source='departure_time', required=False, allow_null=True)
    arrive = serializers.CharField(source='arrival_time', required=False, allow_null=True)
    train = serializers.CharField(source='train_number', required=False, allow_null=True)
    
    # Accommodation fields
    location = serializers.CharField(source='location_name', required=False, allow_null=True)
    destination_id = serializers.CharField(source='destination.id', read_only=True)
    is_reviewable = serializers.SerializerMethodField()

    class Meta:
        model = Booking
        fields = [
            'type', 'booking_id', 'class_label', 'price_rp',
            'from_loc', 'to_loc', 'date', 'departure', 'arrive',
            'train', 'carriage', 'seat', 'image_url', 'stay_date', 
            'stay_duration', 'bed_type', 'location',
            'operator', 'flight_number', 'terminal', 'flight_class',
            'bus_class', 'bus_number', 'car_plate', 'driver_name',
            'flight_route', 'latitude', 'longitude', 'service_fee', 'discount_rp',
            'destination_id', 'is_reviewable'
        ]

    def get_type(self, obj):
        mapping = {
            'CAR_TICKET': 'Car Ticket',
            'BUS_TICKET': 'Bus Ticket',
            'TRAIN_TICKET': 'Train Ticket',
            'PLANE_TICKET': 'Plane Ticket',
            'ACCOMMODATION': 'Accommodation Ticket',
        }
        return mapping.get(obj.booking_type, 'Unknown')

    def get_is_reviewable(self, obj):
        request = self.context.get('request')
        if not request or not request.user.is_authenticated:
            return False

        if obj.status != 'PAID':
            return False

        if not obj.destination:
            return False

        # Check manual trigger
        if obj.manual_review_trigger:
            return not Review.objects.filter(user=request.user, destination=obj.destination).exists()

        # Check date
        target_date_str = obj.stay_date or obj.date
        if target_date_str:
            try:
                # Format: YYYY-MM-DD
                target_date = date.fromisoformat(target_date_str)
                if target_date <= date.today():
                    return not Review.objects.filter(user=request.user, destination=obj.destination).exists()
            except (ValueError, TypeError):
                pass

        return False

    def to_representation(self, instance):
        ret = super().to_representation(instance)
        # Rename specific mapping for Flutter CartTicket
        mapping = {
            'from_loc': 'from',
            'to_loc': 'to'
        }
        for old_key, new_key in mapping.items():
            if old_key in ret:
                ret[new_key] = ret.pop(old_key)
        
        # Fallback coordinate mapping for transport tickets
        if not ret.get('latitude') or not ret.get('longitude'):
            destination_coords = {
                'Jakarta': (-6.2088, 106.8456),
                'Bali': (-8.4095, 115.1889),
                'Yogyakarta': (-7.7970, 110.3705),
                'Bandung': (-6.9175, 107.6191),
                'Surabaya': (-7.2504, 112.7688),
            }
            iata_coords = {
                'CGK': (-6.1256, 106.6560),
                'DPS': (-8.7482, 115.1675),
                'SUB': (-7.3797, 112.7875),
                'KNO': (3.642, 98.885),
                'UPG': (-5.062, 119.554),
                'YIA': (-7.900, 110.050),
                'BPN': (-1.268, 116.895),
                'BTH': (1.121, 104.118),
                'SRG': (-6.984, 110.375),
                'PLM': (-2.897, 104.701),
                'SIN': (1.3644, 103.9915),
                'KUL': (2.7456, 101.7099),
                'BKK': (13.6900, 100.7501),
                'DXB': (25.2532, 55.3657),
                'SYD': (-33.9399, 151.1753),
                'LHR': (51.4700, -0.4543),
                'CDG': (49.0097, 2.5479),
                'AMS': (52.311, 4.768),
                'FRA': (50.033, 8.571),
                'JFK': (40.6413, -73.7781),
                'LAX': (33.9416, -118.4085),
                'HND': (35.5494, 139.7798),
                'NRT': (35.7647, 140.3864),
                'ICN': (37.4602, 126.4407),
                'HKG': (22.3080, 113.9185),
            }
            target_loc = ret.get('to') or ret.get('location')
            if target_loc:
                target_upper = target_loc.strip().upper()
                if target_upper in iata_coords:
                    ret['latitude'], ret['longitude'] = iata_coords[target_upper]
                else:
                    matched = False
                    for key, (lat, lng) in destination_coords.items():
                        if key.lower() in target_loc.lower():
                            ret['latitude'] = lat
                            ret['longitude'] = lng
                            matched = True
                            break
                    
                    if not matched:
                        ret['latitude'] = -6.2088
                        ret['longitude'] = 106.8456
                        
        return ret

class TicketModelSerializer(serializers.ModelSerializer):
    class_type = serializers.CharField(source='class_label')
    from_loc = serializers.CharField(source='from_location')
    to_loc = serializers.CharField(source='to_location')
    departure_time = serializers.CharField()
    arrival_time = serializers.CharField()
    train_number = serializers.CharField()

    class Meta:
        model = Booking
        fields = [
            'class_type', 'from_loc', 'to_loc', 'date',
            'departure_time', 'arrival_time', 'train_number',
            'carriage', 'seat_number', 'seat', 'operator',
            'flight_number', 'terminal', 'flight_class',
            'bus_class', 'bus_number', 'car_plate', 'driver_name',
            'flight_route', 'latitude', 'longitude', 'service_fee', 'discount_rp'
        ]

    def to_representation(self, instance):
        ret = super().to_representation(instance)
        mapping = {
            'from_loc': 'from',
            'to_loc': 'to'
        }
        for old_key, new_key in mapping.items():
            if old_key in ret:
                ret[new_key] = ret.pop(old_key)

        # Fallback coordinate mapping for transport tickets
        if not ret.get('latitude') or not ret.get('longitude'):
            destination_coords = {
                'Jakarta': (-6.2088, 106.8456),
                'Bali': (-8.4095, 115.1889),
                'Yogyakarta': (-7.7970, 110.3705),
                'Bandung': (-6.9175, 107.6191),
                'Surabaya': (-7.2504, 112.7688),
            }
            iata_coords = {
                'CGK': (-6.1256, 106.6560),
                'DPS': (-8.7482, 115.1675),
                'SUB': (-7.3797, 112.7875),
                'KNO': (3.642, 98.885),
                'UPG': (-5.062, 119.554),
                'YIA': (-7.900, 110.050),
                'BPN': (-1.268, 116.895),
                'BTH': (1.121, 104.118),
                'SRG': (-6.984, 110.375),
                'PLM': (-2.897, 104.701),
                'SIN': (1.3644, 103.9915),
                'KUL': (2.7456, 101.7099),
                'BKK': (13.6900, 100.7501),
                'DXB': (25.2532, 55.3657),
                'SYD': (-33.9399, 151.1753),
                'LHR': (51.4700, -0.4543),
                'CDG': (49.0097, 2.5479),
                'AMS': (52.311, 4.768),
                'FRA': (50.033, 8.571),
                'JFK': (40.6413, -73.7781),
                'LAX': (33.9416, -118.4085),
                'HND': (35.5494, 139.7798),
                'NRT': (35.7647, 140.3864),
                'ICN': (37.4602, 126.4407),
                'HKG': (22.3080, 113.9185),
            }
            target_loc = ret.get('to') or ret.get('location')
            if target_loc:
                target_upper = target_loc.strip().upper()
                if target_upper in iata_coords:
                    ret['latitude'], ret['longitude'] = iata_coords[target_upper]
                else:
                    matched = False
                    for key, (lat, lng) in destination_coords.items():
                        if key.lower() in target_loc.lower():
                            ret['latitude'] = lat
                            ret['longitude'] = lng
                            matched = True
                            break
                    
                    if not matched:
                        ret['latitude'] = -6.2088
                        ret['longitude'] = 106.8456

        return ret

class CheckoutDetailsSerializer(serializers.ModelSerializer):
    ticket = TicketModelSerializer(source='*')
    purchase_items = PurchaseItemSerializer(many=True, read_only=True)
    total_price = serializers.SerializerMethodField()

    class Meta:
        model = Booking
        fields = ['ticket', 'purchase_items', 'total_price']

    def get_total_price(self, obj):
        return f"Rp {obj.price_rp:,}"
