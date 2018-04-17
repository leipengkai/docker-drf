# -*- coding: utf-8 -*-
__author__ = 'bobby'

from rest_framework import serializers
from django.db.models import Q

from goods.models import Goods, GoodsCategory, HotSearchWords, GoodsImage, Banner
from goods.models import GoodsCategoryBrand, IndexAd,GoodsComment,GoodsCommentIamge
from users.models import UserProfile


class CategorySerializer3(serializers.ModelSerializer):
    class Meta:
        model = GoodsCategory
        fields = "__all__"


class CategorySerializer2(serializers.ModelSerializer):
    sub_cat = CategorySerializer3(many=True)

    class Meta:
        model = GoodsCategory
        fields = "__all__"


class CategorySerializer(serializers.ModelSerializer):
    sub_cat = CategorySerializer2(many=True)

    class Meta:
        model = GoodsCategory
        fields = "__all__"


class GoodsImageSerializer(serializers.ModelSerializer):
    class Meta:
        model = GoodsImage
        fields = ("image", )


class GoodsSerializer(serializers.ModelSerializer):
    category = CategorySerializer()
    images = GoodsImageSerializer(many=True)

    class Meta:
        model = Goods
        fields = "__all__"


class HotWordsSerializer(serializers.ModelSerializer):
    class Meta:
        model = HotSearchWords
        fields = "__all__"


class GoodsFrontImageSerializer(serializers.ModelSerializer):
    class Meta:
        model = Goods
        fields = ('name', 'goods_front_image', )


class BannerSerializer(serializers.ModelSerializer):
    class Meta:
        model = Banner
        fields = "__all__"


class BrandSerializer(serializers.ModelSerializer):
    class Meta:
        model = GoodsCategoryBrand
        fields = "__all__"


class GoodsFrontImageSerializer(serializers.ModelSerializer):
    class Meta:
        model = Goods
        fields = ('name', 'goods_front_image', )


class IndexCategorySerializer(serializers.ModelSerializer):
    brands = BrandSerializer(many=True)
    goods = serializers.SerializerMethodField()  # 得到一级类目下的所有商品,而不是直属下的商品
    sub_cat = CategorySerializer2(many=True)
    ad_goods = serializers.SerializerMethodField()

    def get_ad_goods(self, obj):
        goods_json = {}
        ad_goods = IndexAd.objects.filter(category_id=obj.id, )
        if ad_goods:
            good_ins = ad_goods[0].goods
            # serializer嵌套时,media没有域名
            goods_json = GoodsSerializer(
                good_ins, many=False, context={
                    'request': self.context['request']}).data
        return goods_json

    def get_goods(self, obj):
        all_goods = Goods.objects.filter(
            Q(
                category_id=obj.id) | Q(
                category__parent_category_id=obj.id) | Q(
                category__parent_category__parent_category_id=obj.id))
        goods_serializer = GoodsSerializer(
            all_goods, many=True, context={
                'request': self.context['request']})
        return goods_serializer.data

    class Meta:
        model = GoodsCategory
        fields = "__all__"

class GoodsCommentIamgeSerializer(serializers.ModelSerializer):
    class Meta:
        model = GoodsCommentIamge
        fields = ('image')

class UserProfileSerializer(serializers.ModelSerializer):
    class Meta:
        model = UserProfile
        fields = ('name','mobile','image')

class GoodsCommentSerializer(serializers.ModelSerializer):
    comment =  GoodsCommentIamgeSerializer(many=True,read_only=True)
    users =  UserProfileSerializer()
    goods = GoodsSerializer()
    # goods = serializers.PrimaryKeyRelatedField(required=True, queryset=Goods.objects.all())
    class Meta:
        model = GoodsComment
        fields = '__all__'

    # 要验证此用户已经购买此商品
    # def create(self, validated_data):
        # # 已经序列化的好的数据: validated_data
        # user = self.context["request"].user
        # nums = validated_data["nums"]
        # existed = ShoppingCart.objects.filter(user=user, goods=goods)
        # return existed

###########################################################################
class GoodsSimpleSerializer(serializers.ModelSerializer):
    # 验证字段并提供错误提示,并限制post传递的字段,get展示的字段
    # 按MODEL序列化并对数据库进行增删改查,
    # 可以提供帮助文档的字段

    # Serializer
    # 需要显示的指明与Model中对应的字段  才能显示字段内容(get), 相当于说是跟Model没有关系了
    # 灵活性比较高(灵活的操作数据库,并可以不用去验证Model字段的正确性)
    # validated_data是已经序列化好的数据了:Goods 如果是没有序列化好的的数据的话,就是goods_id

    # goods = serializers.PrimaryKeyRelatedField(required=True, queryset=Goods.objects.all())
    # 必须要指定queryset,增加商品购物车,不重新创建一条新记录,而是更新

    # name = serializers.CharField(required=True,max_length=100)
    # 同时如果需要在 Serializer中保存或更新数据库的话,还要重写create() update()

    # username = serializers.CharField(label="用户名", help_text="用户名", required=True, allow_blank=False,# validators=[UniqueValidator(queryset=User.objects.all(), message="用户已经存在")])
    # password = serializers.CharField( # style={'input_type': 'password'},help_text="密码", label="密码", write_only=True, # )
    # def validate_username(self, username):
        # raise serializers.ValidationError("验证码错误")
    # def validate(self, attrs):
        # del attrs["code"]
        # return attrs
    # def create(self, validated_data):
        # # 已经序列化的好的数据: validated_data
        # user = self.context["request"].user
        # nums = validated_data["nums"]
        # existed = ShoppingCart.objects.filter(user=user, goods=goods)
        # return existed

    # def update(self, instance, validated_data):
        # instance.nums = validated_data["nums"]
        # instance.save()
        # return instance

    # ModelSerializer
    # 通过Model字段被映射到相应的序列化程序字段中了,包括字段,create,update()
    # 也可以自己定义Model中没有的字段 ,或者覆盖掉Model中的字段(category在Model中是个外键,覆盖后是个serializer
    category = CategorySerializer()

    class Meta:
        model = Goods  # 指定映射的Model
        fields = "__all__"  # 注意自定义的字段一定要写进来,这里用__all__表示所有字段都包括了,否则需要写明

# 先会去验证Model字段是否合法,然后才到ModelSerializer这边来进行其它的验证
# 包括 serializer字段 (UniqueValidator)--> validate_字段()-->  validate() -->create()

# 其中write_only=True的话,则表示在序列化给前端时(serializer.data)就不会序列化这个字段了.

# 通过Serializer验证过后的 return 返回到 request.data中了？
