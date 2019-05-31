# -*- coding: utf-8 -*-

from import_export import resources
from import_export.fields import Field
from django.utils.safestring import mark_safe

from .models import OrderInfo

class OrderInfoDetailResource(resources.ModelResource):
    # 详细地址 = Field(attribute='address__address', column_name='详细地址')
    订单号 = Field(attribute='order_sn', column_name='订单号')
    收货人 = Field(attribute='orderShipping__ship_name', column_name='收货人')
    收货人电话 = Field(attribute='orderShipping__ship_mobile', column_name='收货人电话')
    运费 = Field(attribute='payment_fee', column_name='运费')
    支付时间 = Field(attribute='pay_time', column_name='支付时间')
    购买人 = Field(attribute='user_id__username', column_name='购买人')
    订单总数量 = Field(attribute='order_num', column_name='订单总数量')
    订单金额 = Field(attribute='order_amount', column_name='订单金额')
    商品金额 = Field(attribute='goods_price', column_name='商品金额')
    支付订单号 = Field(attribute='pay_sn', column_name='支付订单号')
    支付手续费 = Field(attribute='payment_fee', column_name='支付手续费')





    class Meta:
        model = OrderInfo
        #定义导出excel有那些列
        fields = ('购买人','地区','详细地址','订单号','支付订单号','支付状态','支付方式','订单总数量','订单金额','商品金额',
                  '运费','支付时间','收货人','收货人电话','支付手续费','详细商品')

        #定义导出excel类的顺序
        export_order = ('地区','详细地址', '收货人','收货人电话','订单金额','商品金额','运费','支付手续费', '支付状态','购买人', '订单号', '支付订单号',  '支付方式', '订单总数量', '支付时间','详细商品')

    地区 = Field()
    def dehydrate_地区(self, orderInfo):
        shipping = orderInfo.orderShipping
        return '{} {} {} {}'.format(shipping.ship_country,shipping.ship_province,shipping.ship_city,shipping.ship_district)

    支付状态 = Field()
    def dehydrate_支付状态(self,orderInfo):
        return '{}'.format(orderInfo.get_pay_status_display())

    支付方式 = Field()
    def dehydrate_支付方式(self,orderInfo):
        return '{}'.format(orderInfo.get_pay_type_display())

    详细地址 = Field()
    def dehydrate_详细地址(self, orderInfo):
        shipping = orderInfo.orderShipping
        return '{}'.format(shipping.ship_address)


    详细商品 = Field()
    def dehydrate_详细商品(self, orderInfo):
        result = ''
        orderGoods = orderInfo.orderGoodsOrder.all()
        for ordergoods in orderGoods:
            goods = ordergoods.goods
            goods_num = ordergoods.goods_num
            # goods_front_image = mark_safe(u'<img src="%s" width="100px">' % goods.goods_front_image.url)
            result += '{}(商品唯一货号:{})\t 数量{}(商品单价:{})\n'.format(goods.name,goods.goods_sn,goods_num,goods.shop_price)
# goods_sn shop_price name
# goods_front_image 
        return result
