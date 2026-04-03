from django.urls import path, include
from rest_framework.routers import DefaultRouter
from .views import BookingViewSet, DestinationViewSet

router = DefaultRouter()
router.register(r'destinations', DestinationViewSet, basename='destination')
router.register(r'', BookingViewSet, basename='booking')

urlpatterns = [
    path('', include(router.urls)),
]
