from django.urls import path
from .views import PromotionListView, CollectCouponView

urlpatterns = [
    path('', PromotionListView.as_view(), name='promotion-list'),
    path('collect/', CollectCouponView.as_view(), name='collect-coupon'),
]
