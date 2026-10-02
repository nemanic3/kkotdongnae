from datetime import time, timedelta
from zoneinfo import ZoneInfo

from django.conf import settings
from django.contrib.auth import get_user_model
from django.core.management.base import BaseCommand, CommandError
from django.db import transaction
from django.utils import timezone

from shops.models import Product, Shop, Slot


class Command(BaseCommand):
    help = "로컬 시연용 계정, 꽃집 3곳, 상품 9개와 7일 예약 슬롯을 생성합니다."

    @transaction.atomic
    def handle(self, *args, **options):
        if not settings.DEBUG:
            raise CommandError("seed_demo는 DEBUG=True인 개발 환경에서만 실행하세요.")

        users = get_user_model().objects
        customer, created = users.get_or_create(
            email="demo@kkotdongnae.test", defaults={"name": "꽃동네 체험회원"}
        )
        if created:
            customer.set_password("KkotDemo123!")
            customer.save(update_fields=["password"])

        today = timezone.now().astimezone(ZoneInfo("Asia/Seoul")).date()
        for index, (name, address, lat, lng) in enumerate([
            ("꽃동네 강남점", "서울특별시 강남구 강남대로 396", "37.4979000", "127.0276000"),
            ("꽃동네 역삼점", "서울특별시 강남구 테헤란로 152", "37.5006000", "127.0364000"),
            ("꽃동네 서초점", "서울특별시 서초구 서초대로 398", "37.4963000", "127.0246000"),
        ], start=1):
            owner, created = users.get_or_create(
                email=f"demo-seller-{index}@kkotdongnae.test",
                defaults={"name": f"시연 판매자 {index}"},
            )
            if created:
                owner.set_unusable_password()
                owner.save(update_fields=["password"])
            shop, _ = Shop.objects.get_or_create(owner=owner, defaults={
                "name": name, "address": address, "lat": lat, "lng": lng,
                "description": "꽃동네 졸업프로젝트 시연용 가상 꽃집입니다.",
                "phone": "02-000-0000", "open_time": time(9), "close_time": time(20),
                "same_day": True, "pickup": True, "delivery": True,
            })
            for product_name, kind, price in [
                ("분홍 장미 꽃다발", "bouquet", 35000),
                ("계절 꽃바구니", "basket", 55000),
                ("초록 반려식물", "plant", 25000),
            ]:
                Product.objects.get_or_create(shop=shop, name=product_name, defaults={
                    "product_type": kind, "price": price,
                    "description": "시연용 샘플 상품", "same_day_available": True,
                })
                for day in range(7):
                    for hour in (10, 14, 18):
                        Slot.objects.get_or_create(
                            shop=shop, date=today + timedelta(days=day),
                            start_time=time(hour), end_time=time(hour + 1),
                            product_type=kind, defaults={"capacity": 5},
                        )

        self.stdout.write(self.style.SUCCESS(
            "시딩 완료: 꽃집 3곳, 상품 9개, 오늘부터 7일간 슬롯 189개. "
            "기존 데이터와 비밀번호, 예약 수는 유지됩니다."
        ))
        self.stdout.write("신규 체험계정: demo@kkotdongnae.test / KkotDemo123!")
