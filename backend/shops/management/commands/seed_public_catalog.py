"""새 운영 DB에 가상 매장만 추가. 로그인 가능한 계정이나 기존 데이터 변경 없음."""
from datetime import time
from django.contrib.auth import get_user_model
from django.core.management.base import BaseCommand
from django.db import transaction
from shops.models import Shop, Product

class Command(BaseCommand):
    help = '명시적으로 표시된 가상 꽃집 카탈로그를 생성합니다.'
    @transaction.atomic
    def handle(self, *args, **kwargs):
        for index, (name, address, lat, lng) in enumerate([
            ('꽃동네 강남점 (가상 매장)', '서울특별시 강남구 강남대로 396', '37.4979', '127.0276'),
            ('꽃동네 역삼점 (가상 매장)', '서울특별시 강남구 테헤란로 152', '37.5006', '127.0364'),
            ('꽃동네 서초점 (가상 매장)', '서울특별시 서초구 서초대로 398', '37.4963', '127.0246'),
        ], 1):
            owner, created = get_user_model().objects.get_or_create(
                email=f'public-catalog-{index}@kkotdongnae.test', defaults={'name': '가상 매장'})
            if created:
                owner.set_unusable_password()
                owner.save(update_fields=['password'])
            shop, _ = Shop.objects.get_or_create(owner=owner, defaults={
                'name': name, 'address': address, 'lat': lat, 'lng': lng,
                'phone': '', 'description': '프로젝트 시연용 가상 꽃집입니다. 실제 구매·예약은 제공하지 않습니다.',
                'open_time': time(9), 'close_time': time(20), 'pickup': False,
            })
            for name, kind, price in [('분홍 장미 꽃다발', 'bouquet', 35000), ('계절 꽃바구니', 'basket', 55000), ('초록 반려식물', 'plant', 25000)]:
                Product.objects.get_or_create(shop=shop, name=name, defaults={
                    'product_type': kind, 'price': price, 'description': '가상 상품', 'is_available': False})
        self.stdout.write('Public fictional catalog prepared; existing records preserved')
