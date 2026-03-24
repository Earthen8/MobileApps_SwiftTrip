from django.db import models
from django.conf import settings

class FAQ(models.Model):
    question = models.CharField(max_length=255)
    answer = models.TextField()

    class Meta:
        verbose_name = "FAQ"
        verbose_name_plural = "FAQs"

    def __str__(self):
        return self.question

class SupportTicket(models.Model):
    PROBLEM_TYPES = [
        ('Bugs', 'Bugs'),
        ('Text Error', 'Text Error'),
        ('Button Malfunctions', 'Button Malfunctions'),
        ('Design Error', 'Design Error'),
        ('Others', 'Others'),
    ]

    LOCATIONS = [
        ('Home', 'Home'),
        ('Chat AI', 'Chat AI'),
        ('Keranjang', 'Keranjang'),
        ('Pembayaran', 'Pembayaran'),
        ('Others', 'Others'),
    ]

    PUBLISH_TYPES = [
        ('Public', 'Public'),
        ('Private', 'Private'),
    ]

    TICKET_STATUS = [
        ('pending', 'Pending'),
        ('solved', 'Solved'),
        ('replied', 'Replied'),
    ]

    user = models.ForeignKey(settings.AUTH_USER_MODEL, on_delete=models.CASCADE, related_name='support_tickets')
    problem_type = models.CharField(max_length=50, choices=PROBLEM_TYPES, null=True, blank=True)
    location = models.CharField(max_length=50, choices=LOCATIONS, null=True, blank=True)
    publish_type = models.CharField(max_length=20, choices=PUBLISH_TYPES, default='Private')
    header = models.CharField(max_length=255)
    statement = models.TextField()
    attachment = models.FileField(upload_to='support_attachments/', null=True, blank=True)
    status = models.CharField(max_length=20, choices=TICKET_STATUS, default='pending')
    created_at = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return f"{self.header} ({self.user.email})"

class TicketReply(models.Model):
    ticket = models.ForeignKey(SupportTicket, on_delete=models.CASCADE, related_name='replies')
    user = models.ForeignKey(settings.AUTH_USER_MODEL, on_delete=models.CASCADE)
    body = models.TextField()
    created_at = models.DateTimeField(auto_now_add=True)

    class Meta:
        verbose_name_plural = "Ticket Replies"

    def __str__(self):
        return f"Reply to {self.ticket.header} by {self.user.email}"
