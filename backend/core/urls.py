"""
URL configuration for core project.

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/6.0/topics/http/urls/
"""
from django.contrib import admin
from django.urls import path, include
from core import views

urlpatterns = [
    path('admin/', admin.site.urls),
    path('api/auth/', include('dj_rest_auth.urls')),
    path('api/auth/registration/', include('dj_rest_auth.registration.urls')),
    path('api/auth/send-otp/', views.send_otp, name='send_otp'),
    path('api/auth/verify-otp/', views.verify_otp, name='verify_otp'),
    path('api/auth/update-password/', views.update_password, name='update_password'),
    path('api/auth/delete-account/', views.delete_account, name='delete_account'),
]
