# -*- coding: utf-8 -*-
__author__ = 'bobby'

from rest_framework import serializers
from django.db.models import Q

from goods.models import Goods, GoodsCategory, HotSearchWords, GoodsImage, Banner,Spec,SpecValue,SKU,SKUValue
from goods.models import GoodsCategoryBrand, IndexAd,GoodsComment,GoodsCommentIamge, TestModel
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


class SKUValueSerializer(serializers.ModelSerializer):

    class Meta:
        model = SKUValue
        fields = "__all__"

class SKUSerializer(serializers.ModelSerializer):

    skuvalue = SKUValueSerializer(many=True)

    class Meta:
        model = SKU
        fields = "__all__"


class SpecValueSerializer(serializers.ModelSerializer):

    class Meta:
        model = SpecValue
        fields = "__all__"

class SpecSerializer(serializers.ModelSerializer):

    # 反向关联时,一定要写明,不然不会有所显示
    specvalue = SpecValueSerializer(many=True) # 反向关联一个serializer 一对一
    # specvalue = serializers.PrimaryKeyRelatedField(many=True, read_only=True) # 反向关联一个specvalue的id
    goods = serializers.PrimaryKeyRelatedField(many=True, read_only=True) # 多对多

    class Meta:
        model = Spec
        fields = "__all__"

class GoodsSerializer(serializers.ModelSerializer):
    category = CategorySerializer()
    images = GoodsImageSerializer(many=True)
    spec = SpecSerializer(many=True)
    sku = SKUSerializer(many=True)

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
class GoodsSimpleSerializer(serializers.ModelSerializer): # 在数据保存之前进行操作:instance.save()
    # 验证字段并提供错误提示,并限制post传递的字段,get展示的字段,或者post和get的字段不同,则定义不同的serializer来满足需求
    # 按MODEL序列化并对数据库进行增删改查
    # 可以提供帮助文档的字段
    # 关联的ForeignKey,OTO表需要先有一条数据,再向admin注册(进行能内容的查看,管理)
    # ModelSerializer已经重写update(),所以可以进行更新操作:put,patch.而基本的Serializer是没有重写的

    # Serializer  
    # 需要显示的指明与Model中对应的字段  才能显示字段内容(get), 相当于说是跟Model没有关系了
    # 灵活性比较高(灵活的操作数据库,并可以不用去验证Model字段的正确性)
    # validated_data是已经序列化好的数据了:Goods 如果是没有序列化好的的数据的话,就是goods_id

    # name = serializers.CharField(required=True,max_length=100)
    # 同时如果需要在 Serializer中保存或更新数据库的话,还要重写create() update()

    # username = serializers.CharField(label="用户名", help_text="用户名", required=True, allow_blank=False, validators=[UniqueValidator(queryset=User.objects.all(), message="用户已经存在")])
    # error_messages={
    #                    'blank': '请输入验证码',
    #                    'required': '请输入正确的验证码',
    #                    'max_length': '验证码格式错误',
    #                    'min_length': '验证码格式错误',
    #                    'invalid': '请输入正确的验证码',
    #                },
    # password = serializers.CharField( style={'input_type': 'password'},help_text="密码", label="密码", write_only=True,)

    # create_time = serializers.DateTimeField(format="%Y-%m-%d %H:%M:%S", required=False, read_only=True)



    # 得到传入的值
    # def validate_name(self, name:可以自己定义默认的,一般是由用户输入) obj:则是class meta的model data
        # raise serializers.ValidationError("验证码错误")
        # name=self.initial_data['name']
        # comment_goods = xxSerializer(xxobjects.filter(), many=True, #
               # context={'request': self.context['request']}).data # 为serializer中的添加url
        # request = self.context.get('request')
        # d['xximg'] = request.build_absolute_uri(xximg.url) # d为dict类型

    # def validate(self, attrs):
        # del attrs["code"]
        # return attrs

    # def create(self, validated_data):
        # self.initial_data # 所有字段
        # # 已经序列化的好的数据: validated_data  指定model中的字段
        # user = self.context["request"].user
        # existed = UserAddress.objects.filter(user=user)
        # if not existed:
            # validated_data['default_address'] = '1'
        # return  UserAddress.objects.create(**validated_data)

    # def update(self, instance, validated_data):
        # user = self.context["request"].user
        # default_address = validated_data["default_address"]
        # existed = UserAddress.objects.filter(user=user).filter(default_address='1')
        # if existed and default_address == '1':
            # for i in existed:
                # i.default_address = '0'
                # i.save()

        # # instance.default_address = default_address 下面是源码
        # info = get_field_info(instance)
        # for attr, value in validated_data.items():
            # if attr in info.relations and info.relations[attr].to_many:
                # field = getattr(instance, attr)
                # field.set(value)
            # else:
                # setattr(instance, attr, value)
        # instance.save()
        # return instance

    # ModelSerializer
    # 默认情况下,通过Model字段被映射到相应的序列化程序字段中了,包括字段,create,update()
    # 也可以自己定义Model中没有的字段 ,或者覆盖掉Model中的字段(category在Model中是个外键,覆盖后是个serializer
    category = CategorySerializer()

    class Meta:
        model = Goods  # 指定映射的Model
        # validators = [  # UserFav  
            # UniqueTogetherValidator(
                # queryset=UserFav.objects.all(),
                # fields=('user', 'goods'),
                # message="已经收藏"
            # )
        # ]
        fields = "__all__"  # 注意自定义的字段一定要写进来,这里用__all__表示所有字段都包括了,否则需要写明
        # exclude = ["is_deleted"] # exclude  


# 先会去验证Model字段是否合法,然后才到ModelSerializer这边来进行其它的验证
# 包括 serializer字段 (UniqueValidator)--> validate_字段()-->  validate() -->create()

# 其中write_only=True的话,则表示在序列化给前端时(serializer.data)就不会序列化这个字段了.

# 通过Serializer验证过后的 return 返回到 request.data中了？
    
    # serializer_related  购物车
    # goods = serializers.PrimaryKeyRelatedField(required=True, queryset=Goods.objects.filter( goods_num__gte=1))
    # son_cat = serializers.SerializerMethodField()

    # def get_son_cat(self, obj):
        # """
        # 嵌套类中也支持排序(顶级类目和二级类目一致排序(正反),但不一起排序,他们是分开的)
        # """  
        # ordering = self.context.get('ordering') # views中thisSerializer(category, many=True, context={'ordering': ordering})
        # cat = HelpCategory.objects.filter(parent_id=obj.category_id)
        # if ordering:
            # cat = cat.order_by(ordering)
        # cat = HelpCategorySerializer2(
            # cat, many=True).data
        # return cat
    # 必须要指定queryset,post时让其选一个,get时只是一些基本的信息,这里只是个goods_id_list
    # 当然也可以指定其它参数read_only,default
    
    # 但可以在get的serializer_classs中定义一个ModelSerializer定义 来得到具体想要的格式内容
    # goods = GoodsSerializer(many=False, read_only=True)





# blank=False, null=False;POST,PUT会有限制,必须要传递.PATCH可以不传递
