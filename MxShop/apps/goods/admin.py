from django.contrib import admin

from .models import Goods, GoodsCategory, GoodsImage, GoodsCategoryBrand, Banner, HotSearchWords
from .models import IndexAd,Spec,SpecValue,SKU,SKUValue
# Register your models here.


class GoodsAdmin(admin.ModelAdmin):
    '''
    商品
    '''
    list_display = [
        "name",
        "sold_num",
        "shop_price",
        "market_price",
        "goods_num",
        "click_num",
        "fav_num",
        "goods_brief",
        "is_new",
        "is_hot",
        "goods_desc",
        "add_time"]
    list_filter = [
        "name",
        "click_num",
        "sold_num",
        "fav_num",
        "goods_num",
        "market_price",
        "shop_price",
        "is_new",
        "is_hot",
        "add_time",
        "category__name"]
    search_fields = ['name', ]
    list_per_page = 8

    list_editable = ["is_hot", "is_new","goods_num"]
    # fieldsets = [
    # ('basic',{'fields': ['name']}),
    # ('more', {'fields': ['add_time']}),
    # ]
    # style_fields = {"goods_desc": "ueditor"}

    class GoodsImagesInline(admin.StackedInline):
        # class GoodsImagesInline(admin.TabularInline):
        model = GoodsImage
        exclude = ["add_time"]
        extra = 3
        style = 'tab'

    inlines = [GoodsImagesInline]


class GoodsCategoryAdmin(admin.ModelAdmin):
    '''
    商品类别
    '''
    list_display = ["name", "category_type", "parent_category", "add_time"]
    list_filter = ["category_type", "parent_category", "name"]
    search_fields = ['name', ]
    list_per_page = 30


class GoodsBrandAdmin(admin.ModelAdmin):
    '''
    一级商品类目的品牌
    '''
    list_display = ["category", "image", "name", "desc"]

    # def get_context(self):
    # context = super(GoodsBrandAdmin, self).get_context()
    # if 'form' in context:
    # context['form'].fields['category'].queryset = GoodsCategory.objects.filter(category_type=1)
    # return context
    # 需要在model中加入limit_choices_to,就可以在admin控制台上管理对应的内容


class BannerGoodsAdmin(admin.ModelAdmin):
    list_display = ["goods", "image", "index"]


class HotSearchAdmin(admin.ModelAdmin):
    list_display = ["keywords", "index", "add_time"]


class IndexAdAdmin(admin.ModelAdmin):
    list_display = ["category", "goods"]

class SpecAdmin(admin.ModelAdmin):
    list_display = ["name"]
    class SpecValueInline(admin.StackedInline):
        model = SpecValue
        extra = 3
        style = 'tab'
    inlines = [SpecValueInline]

class SpecValueAdmin(admin.ModelAdmin):
    list_display = ["value", "spec"]

class GoodsSKUAdmin(admin.ModelAdmin):
    list_display = ["goods", "name","price","stock"]

    class SKUValueInline(admin.StackedInline):
        model = SKUValue
        extra = 3
        style = 'tab'
    inlines = [SKUValueInline]

class SKUValueAdmin(admin.ModelAdmin):
    list_display = ["sku", "specvalue"]

admin.site.register(Goods, GoodsAdmin)

admin.site.register(GoodsCategory, GoodsCategoryAdmin)
admin.site.register(Banner, BannerGoodsAdmin)
admin.site.register(GoodsCategoryBrand, GoodsBrandAdmin)

admin.site.register(HotSearchWords, HotSearchAdmin)
admin.site.register(IndexAd, IndexAdAdmin)

admin.site.register(Spec, SpecAdmin)
admin.site.register(SpecValue,SpecValueAdmin)
admin.site.register(SKU, GoodsSKUAdmin)
admin.site.register(SKUValue, SKUValueAdmin)
