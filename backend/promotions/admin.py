from django.contrib import admin
from .models import Promotion


@admin.register(Promotion)
class PromotionAdmin(admin.ModelAdmin):
    list_display = ('title', 'code', 'promotion_type', 'date_range')
    search_fields = ('title', 'description', 'code')
    filter_horizontal = ('collected_by',)
