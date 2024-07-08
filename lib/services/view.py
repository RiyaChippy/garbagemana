from django.shortcuts import render, get_object_or_404
from .services.firestore_service.py import get_user_address

def user_address_view(request, user_id):
    address_data = get_user_address(user_id)
    if address_data:
        return render(request, 'user_address.html', {'address_data': address_data})
    else:
        return render(request, 'user_address.html', {'error': 'User not found or address not available.'})
