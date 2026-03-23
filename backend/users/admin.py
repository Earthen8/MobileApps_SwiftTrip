from django.contrib import admin
from django.contrib.auth.admin import UserAdmin
from .models import User

class CustomUserAdmin(UserAdmin):
    model = User
    # Since we removed username, we must avoid referencing it in fieldsets and other attributes.
    list_display = ('email', 'first_name', 'last_name', 'is_staff', 'is_active')
    list_filter = ('is_staff', 'is_superuser', 'is_active', 'groups')
    search_fields = ('email', 'first_name', 'last_name')
    ordering = ('email',)
    
    # Redefine fieldsets to avoid 'username'
    fieldsets = (
        (None, {'fields': ('email', 'password')}),
        ('Personal Info', {'fields': ('first_name', 'last_name')}),
        ('Permissions', {'fields': ('is_active', 'is_staff', 'is_superuser', 'groups', 'user_permissions')}),
        ('Important dates', {'fields': ('last_login', 'date_joined')}),
    )
    
    # Redefine add_fieldsets for user creation in admin
    add_fieldsets = (
        (None, {
            'classes': ('extrapretty',),
            'fields': ('email', 'password', 'first_name', 'last_name'),
        }),
    )

admin.site.register(User, CustomUserAdmin)
