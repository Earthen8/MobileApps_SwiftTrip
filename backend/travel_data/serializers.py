from rest_framework import serializers
from .models import Destination, Recommendation, Schedule, Coupon, RideOption, UserFavorite

class DestinationSerializer(serializers.ModelSerializer):
    imageUrl = serializers.URLField(source='image_url')
    hasDiscount = serializers.BooleanField(source='has_discount')
    isFavorite = serializers.SerializerMethodField()

    class Meta:
        model = Destination
        fields = ['id', 'name', 'imageUrl', 'rating', 'description', 'price', 'features', 'category', 'hasDiscount', 'isFavorite']

    def get_isFavorite(self, obj):
        user = self.context.get('request').user
        if user.is_authenticated:
            return UserFavorite.objects.filter(user=user, destination=obj).exists()
        return False

class RecommendationSerializer(serializers.ModelSerializer):
    image_url = serializers.URLField(source='image_url', required=False, allow_null=True)
    image_asset = serializers.CharField(required=False, allow_null=True)

    class Meta:
        model = Recommendation
        fields = ['name', 'description', 'image_url', 'image_asset']

class ScheduleSerializer(serializers.ModelSerializer):
    image_url = serializers.URLField(source='image_url', required=False, allow_null=True)
    image_asset = serializers.CharField(required=False, allow_null=True)

    class Meta:
        model = Schedule
        fields = ['title', 'time', 'image_url', 'image_asset']

class CouponSerializer(serializers.ModelSerializer):
    class Meta:
        model = Coupon
        fields = ['title', 'description', 'code']

class RideOptionSerializer(serializers.ModelSerializer):
    passengerCapacity = serializers.IntegerField(source='passenger_capacity')
    priceRp = serializers.IntegerField(source='price_rp')

    class Meta:
        model = RideOption
        fields = ['name', 'duration', 'passengerCapacity', 'priceRp']
