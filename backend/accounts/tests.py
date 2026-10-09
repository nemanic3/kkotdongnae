import secrets
from datetime import time
from django.contrib.auth import get_user_model
from django.test import override_settings
from rest_framework.test import APITestCase
from shops.models import Shop, Product, Reminder
from orders.models import Order

@override_settings(SECURE_SSL_REDIRECT=False, ALLOWED_HOSTS=['testserver'], REST_FRAMEWORK={
    'DEFAULT_AUTHENTICATION_CLASSES': ('rest_framework_simplejwt.authentication.JWTAuthentication',),
})
class UserFlowTests(APITestCase):
    def setUp(self):
        self.password = secrets.token_urlsafe(24)
        self.owner = get_user_model().objects.create_user(email='seller@example.test', password=self.password, name='Test Seller')
        self.user = get_user_model().objects.create_user(email='alice@example.test', password=self.password, name='Alice')
        self.other = get_user_model().objects.create_user(email='bob@example.test', password=self.password, name='Bob')
        self.shop = Shop.objects.create(owner=self.owner, name='Test Flower', address='Test address', lat=37.5, lng=127, phone='', open_time=time(9), close_time=time(20))
        self.product = Product.objects.create(shop=self.shop, name='Test bouquet', price=1000)
    def login(self, user):
        response = self.client.post('/api/auth/login/', {'email': user.email, 'password': self.password})
        self.assertEqual(response.status_code, 200)
        self.client.credentials(HTTP_AUTHORIZATION='Bearer '+response.data['tokens']['access'])
        return response.data['tokens']
    def test_signup_password_validation_and_login_failure(self):
        body={'email':'new@example.test', 'name':'New', 'phone':'', 'password':'123', 'password_confirm':'123'}
        self.assertEqual(self.client.post('/api/auth/signup/',body).status_code,400)
        body.update(password=self.password,password_confirm=self.password)
        self.assertEqual(self.client.post('/api/auth/signup/',body).status_code,201)
        self.assertEqual(self.client.post('/api/auth/login/', {'email':'new@example.test','password':'invalid'}).status_code,400)
    def test_auth_refresh_profile(self):
        self.assertEqual(self.client.get('/api/users/me/').status_code,401)
        tokens=self.login(self.user)
        self.assertEqual(self.client.get('/api/users/me/').data['email'], self.user.email)
        self.assertEqual(self.client.patch('/api/users/me/',{'name':'Updated'}).status_code,200)
        self.assertEqual(self.client.post('/api/auth/refresh/',{'refresh':tokens['refresh']}).status_code,200)
    def test_favorites_are_user_scoped(self):
        self.login(self.user)
        self.assertIn(self.client.post(f'/api/favorites/shops/{self.shop.pk}/').status_code,[200,201])
        self.assertEqual(len(self.client.get('/api/favorites/shops/').data),1)
        self.login(self.other)
        self.assertEqual(self.client.get('/api/favorites/shops/').data,[])
        self.client.delete(f'/api/favorites/shops/{self.shop.pk}/delete/')
        self.login(self.user)
        self.assertEqual(len(self.client.get('/api/favorites/shops/').data),1)
    def test_reviews_and_ownership(self):
        self.login(self.user)
        response=self.client.post('/api/reviews/',{'shop':self.shop.pk,'rating':5,'comment':'Test review'})
        self.assertEqual(response.status_code,201)
        self.assertEqual(len(self.client.get('/api/users/me/reviews/').data),1)
        self.login(self.other)
        self.assertEqual(self.client.get('/api/users/me/reviews/').data,[])
        self.assertEqual(len(self.client.get(f'/api/shops/{self.shop.pk}/reviews/').data),1)
    def test_order_access_and_disabled_payment(self):
        self.login(self.user)
        response=self.client.post('/api/orders/',{'product':self.product.pk,'quantity':1,'receive_type':'pickup'})
        self.assertEqual(response.status_code,201)
        order=Order.objects.get(user=self.user)
        self.assertEqual(self.client.post(f'/api/orders/{order.pk}/pay/').status_code,503)
        self.login(self.other)
        self.assertEqual(self.client.get(f'/api/orders/{order.pk}/').status_code,404)
        self.assertEqual(self.client.get('/api/orders/').data,[])
        self.assertEqual(self.client.get(f'/api/seller/products/{self.product.pk}/').status_code,404)
    def test_nearby_input_and_distance(self):
        self.assertEqual(self.client.get('/api/shops/nearby/?lat=no&lng=127').status_code,400)
        self.assertEqual(self.client.get('/api/shops/nearby/?lat=nan&lng=127').status_code,400)
        self.assertEqual(len(self.client.get('/api/shops/nearby/?lat=37.5&lng=127&radius=1').data),1)
    def test_origin_secret_required(self):
        import os
        from unittest.mock import patch
        with patch.dict(os.environ, {'ORIGIN_PROXY_SECRET':'test-private-proxy-secret'}):
            self.assertEqual(self.client.get('/api/shops/').status_code,403)
            self.assertEqual(self.client.get('/api/shops/',HTTP_X_ORIGIN_SECRET='test-private-proxy-secret').status_code,200)
