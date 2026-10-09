import hmac
import os
from django.http import JsonResponse

class OriginProxyMiddleware:
    def __init__(self, get_response):
        self.get_response = get_response
    def __call__(self, request):
        secret = os.environ.get('ORIGIN_PROXY_SECRET', '')
        if not secret and os.environ.get('DEBUG', '0') != '1':
            return JsonResponse({'detail': 'Service configuration unavailable'}, status=503)
        if secret and not hmac.compare_digest(request.headers.get('X-Origin-Secret', ''), secret):
            return JsonResponse({'detail': 'Forbidden'}, status=403)
        return self.get_response(request)
