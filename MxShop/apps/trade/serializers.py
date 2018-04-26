# -*- coding: utf-8 -*-
__author__ = 'bobby'
import time
import re
from rest_framework import serializers

from goods.models import Goods
from .models import ShoppingCart, OrderInfo, OrderGoods
from goods.serializers import GoodsSerializer, GoodsFrontImageSerializer
from utils.alipay import AliPay
from MxShop.settings import private_key_path, ali_pub_key_path

from MxShop.settings import REGEX_MOBILE


class ShopCartDetailSerializer(serializers.ModelSerializer):
    goods = GoodsSerializer(many=False, read_only=True)

    class Meta:
        model = ShoppingCart
        fields = ("goods", "nums","id")


class ShopCartSerializer(serializers.Serializer):
    user = serializers.HiddenField(
        default=serializers.CurrentUserDefault()
    )
    nums = serializers.IntegerField(required=True, label="数量", min_value=1,
                                    error_messages={
                                        "min_value": "商品数量不能小于一",
                                        "required": "请选择购买数量"
                                    })
    goods = serializers.PrimaryKeyRelatedField(
        required=True, queryset=Goods.objects.filter(
            goods_num__gte=1))
    # def perform_create(self, serializer): 是个具体的goods模型,已经序列化好的MODEL
    # def create(self, request, *args, **kwargs):是个简单的goods id

    def create(self, validated_data):
        # 已经序列化的好的数据: validated_data
        user = self.context["request"].user
        nums = validated_data["nums"]
        goods = validated_data["goods"]  # Goods 如果是没有序列化好的的数据的话,就是goods_id

        existed = ShoppingCart.objects.filter(user=user, goods=goods)

        if existed:
            existed = existed[0]
            existed.nums += nums
            existed.save()
        else:
            existed = ShoppingCart.objects.create(**validated_data)

        return existed

    def update(self, instance, validated_data):
        # 修改商品数量
        goods_sum = validated_data['goods'].goods_num
        num = validated_data["nums"]
        if goods_sum < num:
            raise serializers.ValidationError("库存数量不足")
        instance.nums = num
        instance.save()
        return instance


class OrderGoodsSerialzier(serializers.ModelSerializer):
    goods = GoodsSerializer(many=False)

    class Meta:
        model = OrderGoods
        fields = "__all__"


class OrderDetailSerializer(serializers.ModelSerializer):
    goods = OrderGoodsSerialzier(many=True)
    alipay_url = serializers.SerializerMethodField(read_only=True)

    def get_alipay_url(self, obj):
        alipay = AliPay(
            appid="",
            app_notify_url="http://127.0.0.1:8000/alipay/return/",
            app_private_key_path=private_key_path,
            alipay_public_key_path=ali_pub_key_path,  # 支付宝的公钥，验证支付宝回传消息使用，不是你自己的公钥,
            debug=True,  # 默认False,
            return_url="http://127.0.0.1:8000/alipay/return/"
        )

        url = alipay.direct_pay(
            subject=obj.order_sn,
            out_trade_no=obj.order_sn,
            total_amount=obj.order_amount,
        )
        re_url = "https://openapi.alipaydev.com/gateway.do?{data}".format(
            data=url)

        return re_url

    class Meta:
        model = OrderInfo
        fields = "__all__"


class OrderGoodsFrontImageSerializer(serializers.ModelSerializer):
    goods = GoodsFrontImageSerializer(many=False)

    class Meta:
        model = OrderGoods
        fields = '__all__'


class OrderListSerializer(serializers.ModelSerializer):
    goods = OrderGoodsFrontImageSerializer(many=True)

    class Meta:
        model = OrderInfo
        fields = '__all__'


class OrderSerializer(serializers.ModelSerializer):
    user = serializers.HiddenField(
        default=serializers.CurrentUserDefault()
    )

    pay_status = serializers.CharField(read_only=True)
    trade_no = serializers.CharField(read_only=True)
    order_sn = serializers.CharField(read_only=True)
    pay_time = serializers.DateTimeField(read_only=True)
    add_time = serializers.DateTimeField(read_only=True)
    alipay_url = serializers.SerializerMethodField(read_only=True)
    order_amount = serializers.FloatField(read_only=True)

    def get_alipay_url(self, obj):
        alipay = AliPay(
            appid="",
            app_notify_url="http://127.0.0.1:8000/alipay/return/",
            app_private_key_path=private_key_path,
            alipay_public_key_path=ali_pub_key_path,  # 支付宝的公钥，验证支付宝回传消息使用，不是你自己的公钥,
            debug=True,  # 默认False,
            return_url="http://127.0.0.1:8000/alipay/return/"
        )

        url = alipay.direct_pay(
            subject=obj.order_sn,
            out_trade_no=obj.order_sn,
            total_amount=obj.order_amount,
        )
        re_url = "https://openapi.alipaydev.com/gateway.do?{data}".format(
            data=url)

        return re_url

    def generate_order_sn(self):
        # 当前时间+userid+随机数
        from random import Random
        random_ins = Random()
        order_sn = "{time_str}{userid}{ranstr}".format(
            time_str=time.strftime("%Y%m%d%H%M%S"),
            userid=self.context["request"].user.id,
            ranstr=random_ins.randint(
                10,
                99))

        return order_sn

    def validate_signer_mobile(self, mobile):
        # 验证手机号码是否合法
        if not re.match(REGEX_MOBILE, mobile):
            raise serializers.ValidationError("手机号码非法")

    def validate(self, attrs):
        attrs["order_sn"] = self.generate_order_sn()
        return attrs

    class Meta:
        model = OrderInfo
        fields = "__all__"
