from django.contrib import admin
from .models import Booking, PurchaseItem, Destination, Wishlist

@admin.register(Booking)
class BookingAdmin(admin.ModelAdmin):
    list_display = ('id', 'user', 'booking_type', 'status', 'created_at')
    list_filter = ('status', 'booking_type', 'created_at')
    search_fields = ('user__email', 'from_location', 'to_location')

@admin.register(PurchaseItem)
class PurchaseItemAdmin(admin.ModelAdmin):
    list_display = ('id', 'booking', 'label', 'amount_rp', 'is_discount')
    list_filter = ('is_discount',)
@admin.register(Destination)
class DestinationAdmin(admin.ModelAdmin):
    list_display = ('title', 'category', 'location', 'rating', 'original_price', 'discount_percentage', 'final_price', 'section_tag')
    list_filter = ('category', 'section_tag', 'rating')
    search_fields = ('title', 'location', 'description')
    ordering = ('-rating',)

@admin.register(Wishlist)
class WishlistAdmin(admin.ModelAdmin):
    list_display = ('user', 'item_count')
    search_fields = ('user__username', 'user__email')

    def item_count(self, obj):
        return obj.destinations.count()
    item_count.short_description = 'Destinations Count'
