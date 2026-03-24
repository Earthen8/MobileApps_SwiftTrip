from rest_framework import serializers
from .models import FAQ, SupportTicket, TicketReply

class FAQSerializer(serializers.ModelSerializer):
    class Meta:
        model = FAQ
        fields = ['question', 'answer']

class TicketReplySerializer(serializers.ModelSerializer):
    username = serializers.SerializerMethodField()
    date = serializers.DateTimeField(source='created_at', format='%d %b %Y', read_only=True)
    is_answered = serializers.SerializerMethodField()

    class Meta:
        model = TicketReply
        fields = ['username', 'date', 'body', 'is_answered']

    def get_username(self, obj):
        name = f"{obj.user.first_name} {obj.user.last_name}".strip()
        return name if name else obj.user.email

    def get_is_answered(self, obj):
        # In this simple implementation, we can assume if it's not the ticket owner, it's an answer
        return obj.user != obj.ticket.user

class SupportTicketSerializer(serializers.ModelSerializer):
    # Mapping to TicketItem Flutter model
    title = serializers.SerializerMethodField()
    issued_date = serializers.DateTimeField(source='created_at', format='%d %b %Y', read_only=True)
    preview = serializers.SerializerMethodField()
    is_public = serializers.BooleanField(read_only=True)
    
    # Mapping to CsQuestion Flutter model
    subtitle = serializers.SerializerMethodField()
    body = serializers.CharField(source='statement', required=False) # For CsQuestion
    username = serializers.SerializerMethodField()

    # For RecentQuestion Flutter model
    question = serializers.CharField(source='header', read_only=True)

    class Meta:
        model = SupportTicket
        fields = [
            'id', 'title', 'issued_date', 'preview', 'status', 'is_public', 
            'subtitle', 'body', 'username', 'question',
            'problem_type', 'location', 'publish_type', 'header', 'statement'
        ]
        extra_kwargs = {
            'header': {'write_only': True},
            'statement': {'write_only': True},
        }

    # Custom field renaming for input/output consistency with Flutter
    def to_internal_value(self, data):
        # Map CsRequest fields to model fields if they exist in request
        if 'problem_type' in data:
            data['problem_type'] = data.get('problem_type')
        if 'location' in data:
            data['location'] = data.get('location')
        if 'publish_type' in data:
            data['publish_type'] = data.get('publish_type')
        if 'header' in data:
            data['header'] = data.get('header')
        if 'statement' in data:
            data['statement'] = data.get('statement')
        return super().to_internal_value(data)

    def get_title(self, obj):
        return obj.header

    def get_preview(self, obj):
        return obj.statement[:100] + '...' if len(obj.statement) > 100 else obj.statement

    def get_username(self, obj):
        name = f"{obj.user.first_name} {obj.user.last_name}".strip()
        return name if name else obj.user.email

    def get_subtitle(self, obj):
        date_str = obj.created_at.strftime('%d %b %Y')
        return f"{date_str} {obj.header}"

    def to_representation(self, instance):
        ret = super().to_representation(instance)
        # Ensure 'title' is present for TicketItem
        ret['title'] = instance.header
        # Add 'is_public' logic if needed
        ret['is_public'] = instance.publish_type == 'Public'
        return ret
