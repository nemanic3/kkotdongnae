from django.contrib import admin
from .models import (
    Shop,
    Product,
    Slot,
    Post,
    Review,
    FavoriteShop,
    RecentViewProduct,
    Reminder,
)


admin.site.register(Shop)
admin.site.register(Product)
admin.site.register(Slot)
admin.site.register(Post)
admin.site.register(Review)
admin.site.register(FavoriteShop)
admin.site.register(RecentViewProduct)
admin.site.register(Reminder)