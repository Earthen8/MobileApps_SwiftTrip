from django.contrib import admin
from .models import FAQ, SupportTicket, TicketReply

@admin.register(FAQ)
class FAQAdmin(admin.ModelAdmin):
    list_display = ('question',)
    search_fields = ('question', 'answer')

class TicketReplyInline(admin.TabularInline):
    model = TicketReply
    extra = 1

@admin.register(SupportTicket)
class SupportTicketAdmin(admin.ModelAdmin):
    list_display = ('header', 'user', 'status', 'problem_type', 'publish_type', 'created_at')
    list_filter = ('status', 'problem_type', 'publish_type')
    search_fields = ('header', 'statement', 'user__username')
    inlines = [TicketReplyInline]

@admin.register(TicketReply)
class TicketReplyAdmin(admin.ModelAdmin):
    list_display = ('ticket', 'user', 'created_at')
    list_filter = ('created_at',)
    search_fields = ('body', 'user__username', 'ticket__header')
