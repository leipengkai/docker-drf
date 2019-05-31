import time
import json

from django.contrib import admin
from django.utils.safestring import mark_safe
import pingpp
from import_export.admin import ImportExportModelAdmin

# Register your models here.
from mxshop.apps.goods.models import PaymentReceipt, AlipayReturnWebhookEvent, AlipayCancelWebhookEvent, ShoppingCart, OrderInfo, \
    WebhookEvent, OrderGoods, OrderInfoDetail, OrderInfoRefundReceipt, \
    OrderInfoShopShipping, OrderInfoReturnGoodsReceipt, OrderInfoLog, OrderInfoCancelReceipt
from .resources import OrderInfoDetailResource
from mxshop.apps.goods.filters import StatusListFilter


class PermissionAdmin(admin.ModelAdmin):
    actions = None
    # actions = ['delete_selected', 'a_third_action']
    list_per_page = 30

    def has_add_permission(self, request):
        return False

    def has_delete_permission(self, request, obj=None):
        return False

    def get_readonly_fields(self, request, obj=None):
        result = [f.name for f in self.model._meta.fields]
        return result

    def change_view(self, request, object_id, form_url='', extra_context=None):
        extra_context = extra_context or {}
        extra_context['show_save_and_continue'] = False
        extra_context['show_save'] = False
        return super(PermissionAdmin, self).change_view(request, object_id, extra_context=extra_context)


class ShoppingCartAdmin(PermissionAdmin):
    """
    购物车
    """
    list_display = [
        'user',
        'goods',
        'nums',
        'status',
        'add_time',
        'goods_front_image',
    ]

    list_filter = [
        'user',
        'goods',
        'status',
    ]
    search_fields = ['goods__name', 'user__username']

    def goods_front_image(self, obj):
        # return  obj.goods.image_tag()
        return mark_safe(u'<img src="%s" width="100px">' % obj.goods.goods_front_image.url)

    goods_front_image.short_description = u'商品图片'


class OrderInfoAdmin(ImportExportModelAdmin, PermissionAdmin):
    """
    订单
    """

    def deliveryFee(self, obj):
        """
        运费
        """
        return obj.orderShipping.delivery_fee

    deliveryFee.short_description = u'运费'

    list_filter = ['user_id', 'pay_type', 'order_sn', 'pay_status', 'order_amount']
    list_display = ["order_sn", "pay_status", "order_amount", "deliveryFee", "goods_price", "payment_fee", "add_time"]
    search_fields = ['order_sn', 'pay_sn', 'pay_status', 'order_amount', 'user_id__username']
    date_hierarchy = 'add_time'

    resource_class = OrderInfoDetailResource

    class OrderGoodsInline(admin.StackedInline):
        model = OrderGoods
        can_delete = False

        def has_add_permission(self, request):
            return False

        def get_readonly_fields(self, request, obj=None):
            result = [f.name for f in self.model._meta.fields]
            result.remove('id')
            result.append('goods_front_image')
            result.append('shop_price')
            result.append('goods_sn')

            return result

        def goods_front_image(self, obj):
            # return  obj.goods.image_tag()
            return mark_safe(u'<img src="%s" width="100px">' % obj.goods.goods_front_image.url)

        def shop_price(self, obj):
            return obj.goods.shop_price

        def goods_sn(self, obj):
            return obj.goods.goods_sn

        goods_front_image.short_description = u'商品图片'
        shop_price.short_description = u'商品价格'
        goods_sn.short_description = u'商品唯一货号'
        # style = 'tab'

    class OrderInfoShopShippingInline(admin.StackedInline):
        model = OrderInfoShopShipping
        can_delete = False

        def has_add_permission(self, request):
            return False

        def get_readonly_fields(self, request, obj=None):
            result = [f.name for f in self.model._meta.fields]
            result.remove('id')
            return result

    class OrderInfoDetailInline(admin.StackedInline):
        model = OrderInfoDetail
        style = 'tab'
        can_delete = False

        def has_add_permission(self, request):
            return False

        def get_readonly_fields(self, request, obj=None):
            result = [f.name for f in self.model._meta.fields]
            result.remove('id')
            return result

    class OrderInfoCancelReceiptInline(admin.StackedInline):
        model = OrderInfoCancelReceipt
        style = 'tab'
        can_delete = False

        def has_add_permission(self, request):
            return False

        def get_readonly_fields(self, request, obj=None):
            result = [f.name for f in self.model._meta.fields]
            result.remove('id')
            return result

    inlines = [OrderGoodsInline, OrderInfoDetailInline, OrderInfoShopShippingInline, OrderInfoCancelReceiptInline]


class OrderInfoDetailAdmin(ImportExportModelAdmin, PermissionAdmin):
    """
    订单的详情
    """
    list_display = [
        'user',
        'order_status',
        'product',
        'order_sn',
        'order',
        'goods_front_image',
        'update_time',
        'add_time',
    ]

    list_filter = [
        'user',
        'order_status',
    ]

    search_fields = [
        'user__username',
        'order_sn',
    ]

    def goods_front_image(self, obj):
        # return  obj.goods.image_tag()
        return mark_safe(u'<img src="%s" width="100px">' % obj.product.goods_front_image.url)

    goods_front_image.short_description = u'商品图片'


class OrderInfoShopShippingAdmin(ImportExportModelAdmin, admin.ModelAdmin):
    """
    运单详情
    """
    list_display = ["order", "ship_name", "ship_mobile", "ship_status", "delivery_corp_name", "ship_address"]
    search_fields = ['ship_address', 'ship_status', 'ship_mobile', 'ship_name', 'delivery_type_name',
                     'delivery_corp_name']
    readonly_fields = ['ship_address', 'ship_status', 'ship_mobile', 'ship_name', 'add_time', 'delivery_type_name',
                       'delivery_fee', 'order']
    exclude = ['receipt_time']  # 隐藏状态

    list_filter = ['delivery_corp_name', 'ship_status', ]

    # list_editable = ['ship_status']

    actions = None
    list_per_page = 30

    def has_add_permission(self, request):
        return False

    def has_delete_permission(self, request, obj=None):
        return False

    def get_readonly_fields(self, request, obj=None):
        result = [f.name for f in self.model._meta.fields]
        result.remove('handle_status')
        result.remove('memo')
        result.remove('product_weight_unit')
        result.remove('product_weight')
        result.remove('delivery_sn')
        result.remove('delivery_corp_name')
        return result

    def change_view(self, request, object_id, form_url='', extra_context=None):
        extra_context = extra_context or {}
        extra_context['show_save_and_continue'] = False
        return super(OrderInfoShopShippingAdmin, self).change_view(request, object_id, extra_context=extra_context)

    def get_queryset(self, request):
        """
        Returns a QuerySet of all model instances that can be edited by the
        admin site. This is used by changelist_view.
        """
        qs = super(OrderInfoShopShippingAdmin, self).get_queryset(request)
        return qs.filter(ship_status__in=[14, 21]).filter(order__order_amount__gte=0)

    # 需要在model中加入limit_choices_to,就可以在admin控制台上管理对应的内容

    def save_model(self, request, obj, form, change):
        """
        Given a model instance save it to the database.
        """
        if obj.handle_status == "已处理":
            ship_status = 22

            # 保存订单
            order = OrderInfo.objects.get(id=obj.order_id)
            order.pay_status = ship_status
            order.save()

            orderDetails = OrderInfoDetail.objects.filter(order=obj.order_id)

            # 订单详情
            for od in orderDetails:
                od.update_time = time.strftime("%Y-%m-%d %H:%M:%S", time.localtime())
                od.order_status = ship_status
                od.save()

                # 订单日志，每次操作都会产生日志
                orderinfolog = OrderInfoLog()
                orderinfolog.orderDetail = od
                orderinfolog.order_status = ship_status
                orderinfolog.save()

            # 保存快递
            obj.ship_status = ship_status
            obj.deliver_time = time.strftime("%Y-%m-%d %H:%M:%S", time.localtime())
            obj.save()
        else:
            obj.save()


class OrderInfoRefundReceiptAdmin(admin.ModelAdmin):
    """
    订单置换
    """
    list_display = ["from_goods", "to_goods", "delivery_sn", "add_time"]
    readonly_fields = ['add_time', 'fromOrderDetail', 'toOrder', 'refund_status', 'delivery_corp_name', 'delivery_sn',
                       'goods_delivery_image', 'goods_refused_image', 'goods_from_image', 'goods_to_image',
                       'from_goods', 'to_goods']
    fields = ['handle_status', 'delivery_corp_name2', 'delivery_sn2', 'add_time', 'fromOrderDetail', 'toOrder',
              'refund_status', 'delivery_corp_name', 'delivery_sn', 'goods_delivery_image', 'goods_refused_image',
              'goods_from_image', 'goods_to_image', 'from_goods', 'to_goods']
    raw_id_fields = ("from_goods",)

    list_filter = [
        'refund_status',
        'delivery_corp_name',
    ]

    search_fields = [
        'delivery_sn',
    ]

    list_per_page = 30
    actions = None

    def goods_from_image(self, obj):
        # return  obj.goods.image_tag()
        return mark_safe(u'<img src="%s" width="100px">' % obj.from_image)

    def goods_to_image(self, obj):
        # return  obj.goods.image_tag()
        return mark_safe(u'<img src="%s" width="100px">' % obj.to_image)

    def goods_delivery_image(self, obj):
        # return  obj.goods.image_tag()
        return mark_safe(u'<img src="%s" width="100px">' % obj.delivery_image)

    def goods_refused_image(self, obj):
        # return  obj.goods.image_tag()
        return mark_safe(u'<img src="%s" width="100px">' % obj.refused_image)

    goods_to_image.short_description = u'置换商品'
    goods_from_image.short_description = u'原来商品'
    goods_delivery_image.short_description = u'快递照片'
    goods_refused_image.short_description = u'置换照片'

    exclude = ['from_image', 'to_image', 'delivery_image', 'refused_image']  # 隐藏状态

    def has_add_permission(self, request):
        return False

    def has_delete_permission(self, request, obj=None):
        return False

    def has_change_permission(self, request, obj=None):
        return True

    def get_queryset(self, request):
        qs = super(OrderInfoRefundReceiptAdmin, self).get_queryset(request)
        return qs.filter(fromOrderDetail__order_status__in=[31, 32, 33])

    def save_model(self, request, obj, form, change):
        if obj.fromOrderDetail.order_status == 33 and obj.toOrder.pay_status == 14 and obj.handle_status == "已收到货，进行发货":
            # 保存置换的订单
            obj.fromOrderDetail.order_status = 35
            obj.fromOrderDetail.save()

            # 订单日志，每次操作都会产生日志
            orderinfolog = OrderInfoLog()
            orderinfolog.orderDetail = obj.fromOrderDetail
            orderinfolog.order_status = 35
            orderinfolog.save()

            # 保存订单
            order = OrderInfo.objects.get(id=obj.toOrder.id)
            order.pay_status = 22
            order.save()

            orderDetails = OrderInfoDetail.objects.filter(order=obj.toOrder.id)

            # 订单详情
            for od in orderDetails:
                od.update_time = time.strftime("%Y-%m-%d %H:%M:%S", time.localtime())
                od.order_status = 22
                od.save()

                # 订单日志，每次操作都会产生日志
                orderinfolog = OrderInfoLog()
                orderinfolog.orderDetail = od
                orderinfolog.order_status = 22
                orderinfolog.save()

            # 保存快递
            order.orderShipping.ship_status = 22
            order.orderShipping.deliver_time = time.strftime("%Y-%m-%d %H:%M:%S", time.localtime())
            order.orderShipping.delivery_corp_name = obj.delivery_corp_name2
            order.orderShipping.delivery_sn = obj.delivery_sn2
            order.orderShipping.save()

            obj.save()
        else:
            obj.save()


class OrderInfoReturnGoodsReceiptAdmin(admin.ModelAdmin):
    """
    订单退货
    """
    actions = None
    list_display = ["reason", "delivery_corp_name", "delivery_sn", "refund_status", "handle_status"]
    # readonly_fields = ['add_time', 'returnOrderDetail', 'reason', 'refusedText', 'delivery_corp_name', 'delivery_sn',
    # 'delivery_image', 'refused_image', 'refund_status']

    # list_editable = ['handle_status',]
    exclude = ['delivery_image', 'refused_image']

    def get_readonly_fields(self, request, obj=None):
        result = [f.name for f in self.model._meta.fields]
        result.remove('delivery_image')
        result.remove('refused_image')
        result.remove('handle_status')
        result.append('refusedImage')
        result.append('deliveryImage')
        return result

    def refusedImage(self, obj):
        return mark_safe(u'<img src="%s" width="100px">' % obj.refused_image.url)

    def deliveryImage(self, obj):
        return mark_safe(u'<img src="%s" width="100px">' % obj.delivery_image.url)

    deliveryImage.short_description = u'快递图片'
    refusedImage.short_description = u'退货图片'

    def has_add_permission(self, request):
        return False

    def has_delete_permission(self, request, obj=None):
        return False

    def has_change_permission(self, request, obj=None):
        return True

    def get_queryset(self, request):
        qs = super(OrderInfoReturnGoodsReceiptAdmin, self).get_queryset(request)
        return qs.filter(refund_status__in=[41, 42])

    def save_model(self, request, obj, form, change):
        if obj.refund_status == 42 and obj.handle_status == "已收到货，进行退款":

            # 获取订单详情
            orderDetail = OrderInfoDetail.objects.get(id=obj.returnOrderDetail.id)
            # 获取订单详情
            order = OrderInfo.objects.get(id=orderDetail.order.id)

            ch = pingpp.Charge.retrieve(order.pay_sn)
            re = ch.refunds.create(description=' Description', amount=int(orderDetail.product.shop_price))

            channel = 'wx'
            if order.pay_type == 1:
                channel = 'alipay'
            print(re)
            receipt_body = json.dumps(re)
            print(receipt_body)
            receipt_json = json.loads(receipt_body)
            receipt = PaymentReceipt(pay_id=receipt_json['id'], receipt_body=receipt_body,
                                     user=request.user, type='return', orderDetailId=orderDetail.id,
                                     channel=channel, order_id=order.id)
            # 退货的情况下，保存退款表
            if channel == 'alipay':
                alipayReturnWebhookEvent = AlipayReturnWebhookEvent.objects.create(
                    # 值有点问题
                    pay_id=receipt_json['id'],
                    orderDetail=orderDetail,
                    webhook_message=receipt_body,
                )
                alipayReturnWebhookEvent.save()
            receipt.save()

            obj.save()
        else:
            obj.save()


class AlipayReturnWebhookEventAdmin(PermissionAdmin):
    """
    支付宝退货后 进行退款
    """
    list_display = ["pay_id", "orderDetail", "status", "orderStatus", "add_time"]
    readonly_fields = ["status", "pay_id", "URL", "orderDetail", "add_time", "webhook_message"]
    list_filter = ['status']
    exclude = ['pay_status']  # 隐藏状态

    def URL(self, obj):
        if obj.status == 0:
            alipay_url = obj.webhook_message.get("failure_msg")[obj.webhook_message.get("failure_msg").index('https'):]
            return '<a href="%s" target="_blank">%s</a>' % (alipay_url, "支付宝支付")
        else:
            return "退款完成"

    URL.allow_tags = True
    URL.short_description = '支付宝支付'

    def orderStatus(self, obj):
        """
        订单状态
        """
        return obj.order.get_pay_status_display()

    orderStatus.short_description = u'订单状态'


class AlipayCancelWebhookEventAdmin(PermissionAdmin):
    """
    支付宝取消后 进行退款
    """
    list_display = ["pay_id", "order", "status", "orderStatus", "add_time"]
    readonly_fields = ["status", "pay_id", "URL", "order", "add_time", "webhook_message"]
    list_filter = ['status']
    exclude = ['pay_status']  # 隐藏状态

    def URL(self, obj):
        if obj.status == 0:
            alipay_url = obj.webhook_message.get("failure_msg")[obj.webhook_message.get("failure_msg").index('https'):]
            return '<a href="%s" target="_blank">%s</a>' % (alipay_url, "支付宝支付")
        else:
            return "退款完成"

    URL.allow_tags = True
    URL.short_description = '支付宝支付'

    def orderStatus(self, obj):
        """
        订单状态
        """
        return obj.order.get_pay_status_display()

    orderStatus.short_description = u'订单状态'


class OrderInfoLogAdmin(PermissionAdmin):
    """
    订单历史
    """
    list_display = [
        'add_time',
        'orderDetail',
        'order_status',
    ]

    list_filter = [
        'order_status',
    ]

    search_fields = [
        # 订单号来搜索
        'orderDetail__order_sn',
    ]


class OrderGoodsAdmin(PermissionAdmin):
    """
    订单的商品详情
    """
    list_display = [
        'order',
        'goods',
        'goods_num',
        'add_time',
    ]

    list_filter = [
        'goods',
    ]

    search_fields = [
        # 按订单号和支付号来搜索
        'order__order_sn',
        'order__pay_sn',
    ]


class PaymentReceiptAdmin(PermissionAdmin):
    """
    订单的支付凭证
    """
    list_display = [
        'orderStatus',
        'orderAmount',
        'deliveryFee',
        'goodsPrice',
        'paymentFee',
        'add_time',
        'user',
        'order',
        'pay_id',
        'channel',
        'receipt_body',
    ]

    list_filter = [
        StatusListFilter,
        'user',
        'channel',
    ]

    search_fields = [
        # 按订单号和支付号来搜索
        'order__order_sn',
        'order__pay_sn',
        'pay_id',
    ]

    def orderStatus(self, obj):
        """
        订单状态
        """
        return obj.order.get_pay_status_display()

    def orderAmount(self, obj):
        """
        支付金额
        """
        return obj.order.order_amount

    def deliveryFee(self, obj):
        """
        运费
        """
        return obj.order.orderShipping.delivery_fee

    def goodsPrice(self, obj):
        """
        商品金额
        """
        # s = obj.order.orderGoodsOrder.all()
        # for i in s:
        # return mark_safe(u'<img src="%s" width="100px">' % i.goods.goods_front_image.url)
        return obj.order.goods_price

    def paymentFee(self, obj):
        """
        支付手续费
        """
        return obj.order.payment_fee

    orderStatus.short_description = u'订单状态'
    orderAmount.short_description = u'订单金额(元)'
    deliveryFee.short_description = u'运费(元)'
    goodsPrice.short_description = u'商品金额(元)'
    paymentFee.short_description = u'支付手续费(元)'


class OrderInfoCancelReceiptAdmin(admin.ModelAdmin):
    """
    订单取消
    """
    list_display = ["order", "reason", "add_time"]
    readonly_fields = ['order', 'reason', 'add_time']
    actions = None

    def get_queryset(self, request):
        qs = super(OrderInfoCancelReceiptAdmin, self).get_queryset(request)
        return qs.filter(is_cancel=1)

    def has_add_permission(self, request):
        return False

    def has_change_permission(self, request, obj=None):
        return True

    def has_delete_permission(self, request, obj=None):
        return False

    def save_model(self, request, obj, form, change):

        if obj.handle_result == "同意退款":
            obj.is_cancel = 0
            orders = obj.order
            channel = 'wx'
            if orders.pay_type == 1:
                channel = 'alipay'
            elif orders.pay_type == 2:
                channel = 'wx'
            else:
                channel = 'wx_lite'
            ch = pingpp.Charge.retrieve(orders.pay_sn)
            re = ch.refunds.create(description='Refund Description', amount=int(orders.order_amount * 100))
            print(orders.order_amount * 100)
            print(re)
            receipt_body = json.dumps(re)
            print(receipt_body)
            receipt_json = json.loads(receipt_body)
            receipt = PaymentReceipt(pay_id=receipt_json['id'], receipt_body=receipt_body, user=request.user,
                                     channel=channel, order_id=orders.id)
            receipt.save()

            # 取消的情况下，保存取消表
            if channel == 'alipay':
                alipayCancelWebhookEvent = AlipayCancelWebhookEvent.objects.create(
                    # 值有点问题
                    pay_id=receipt_json['id'],
                    order=orders,
                    webhook_message=receipt_body,
                )
                alipayCancelWebhookEvent.save()

            obj.save()
        else:
            obj.save()


admin.site.register(ShoppingCart, ShoppingCartAdmin)
admin.site.register(OrderInfo, OrderInfoAdmin)
# admin.site.register(OrderInfoDetail, OrderInfoDetailAdmin)
admin.site.register(OrderInfoShopShipping, OrderInfoShopShippingAdmin)
admin.site.register(OrderInfoRefundReceipt, OrderInfoRefundReceiptAdmin)

admin.site.register(OrderInfoReturnGoodsReceipt, OrderInfoReturnGoodsReceiptAdmin)
admin.site.register(AlipayReturnWebhookEvent, AlipayReturnWebhookEventAdmin)
admin.site.register(AlipayCancelWebhookEvent, AlipayCancelWebhookEventAdmin)

# admin.site.register(OrderInfoLog, OrderInfoLogAdmin)
# admin.site.register(OrderGoods, OrderGoodsAdmin)
admin.site.register(PaymentReceipt, PaymentReceiptAdmin)
admin.site.register(OrderInfoCancelReceipt, OrderInfoCancelReceiptAdmin)

