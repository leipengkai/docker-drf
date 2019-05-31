import json
import xadmin
from mxshop.apps.goods.models import PaymentReceipt,AlipayReturnWebhookEvent,AlipayCancelWebhookEvent, OrderInfoCancelReceipt, ShoppingCart, OrderInfo, WebhookEvent, OrderGoods, OrderInfoDetail, OrderInfoRefundReceipt, OrderInfoShopShipping, OrderInfoReturnGoodsReceipt, OrderInfoLog
import time
import pingpp
from django.http import HttpResponseRedirect

class ShoppingCartAdmin(object):
    list_display = ["user", "goods", "nums", ]
    model_icon = 'fa fa-shopping-cart'


class OrderInfoAdmin(object):
    list_display = ["order_sn", "pay_status", "order_amount", "add_time"]
    search_fields = ['order_sn', 'pay_status', 'order_amount']
    list_filter = ['order_sn', 'pay_status', 'order_amount']
    model_icon = 'fa fa-th-list'
    readonly_fields = ["OrderGoods"]
    can_delete = False
    can_add = False
    can_update = False

    def has_add_permission(self):
        return False

    def has_update_permission(self):
        return False

    def has_change_permission(self, request=None):
        return False

    def has_delete_permission(self, request=None):
        return False

    def has_save_permission(self, request=None):
        return False

    def get_readonly_fields(self):
        return [f.name for f in self.model._meta.fields]

    class OrderGoodsInline(object):
        model = OrderGoods
        can_delete = False
        can_add = False
        can_update = False
        style = 'tab'

    class OrderInfoShopShippingInline(object):
        model = OrderInfoShopShipping
        can_delete = False
        can_add = False
        can_update = False

    class OrderInfoDetailInline(object):
        model = OrderInfoDetail
        style = 'tab'
        can_delete = False
        can_add = False
        can_update = False

    inlines = [OrderGoodsInline, OrderInfoDetailInline, OrderInfoShopShippingInline]


class OrderInfoShopShippingAdmin(object):
    list_display = ["order","ship_name", "ship_mobile", "ship_status", "delivery_corp_name", "ship_address"]
    search_fields = ['ship_address', 'ship_status', 'ship_mobile', 'ship_name', 'delivery_type_name', 'delivery_corp_name']
    readonly_fields = ['ship_address', 'ship_status', 'ship_mobile', 'ship_name', 'add_time', 'delivery_type_name', 'delivery_fee', 'order']
    exclude = ['receipt_time']  # 隐藏状态
    model_icon = 'fa fa-th-list'

    def has_add_permission(self):
        return False

    def queryset(self):
        qs = super(OrderInfoShopShippingAdmin, self).queryset()
        return qs.filter(ship_status__in=[14,21]).filter(order__order_amount__gte=0)

    def save_models(self):
        obj = self.new_obj
        if  obj.handle_status=="已处理" :
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

class OrderInfoRefundReceiptAdmin(object):
    list_display = ["from_goods","to_goods","delivery_sn", "add_time"]
    readonly_fields = ['add_time', 'fromOrderDetail', 'toOrder', 'refund_status', 'delivery_corp_name', 'delivery_sn', 'delivery_image', 'refused_image', 'from_image', 'to_image', 'from_goods', 'to_goods']
    model_icon = 'fa fa-th-list'
    fields = ['handle_status','delivery_corp_name2','delivery_sn2','add_time', 'fromOrderDetail', 'toOrder', 'refund_status', 'delivery_corp_name', 'delivery_sn', 'delivery_image', 'refused_image', 'from_image', 'to_image', 'from_goods', 'to_goods']
    raw_id_fields = ("from_goods",)
    can_delete = False
    can_add = False
    can_update = False

    def has_add_permission(self):
        return False

    def has_update_permission(self):
        return False

    def has_change_permission(self, request=None):
        return True

    def has_delete_permission(self, request=None):
        return False

    def has_save_permission(self, request=None):
        return False

    def queryset(self):
        qs = super(OrderInfoRefundReceiptAdmin, self).queryset()
        return qs.filter(fromOrderDetail__order_status__in=[31,32,33])#.filter(toOrder__pay_status__in=[14])

    def save_models(self):
        obj = self.new_obj
        if obj.fromOrderDetail.order_status == 33 and obj.toOrder.pay_status == 14 and obj.handle_status=="已收到货，进行发货" :
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

class OrderInfoReturnGoodsReceiptAdmin(object):
    list_display = ["reason", "delivery_corp_name", "delivery_sn", "refund_status"]
    readonly_fields = ['add_time', 'returnOrderDetail', 'reason', 'refusedText', 'delivery_corp_name', 'delivery_sn',
                       'delivery_image', 'refused_image', 'refund_status']
    model_icon = 'fa fa-th-list'
    can_delete = False
    can_add = False
    can_update = False

    def queryset(self):
        qs = super(OrderInfoReturnGoodsReceiptAdmin, self).queryset()
        return qs.filter(refund_status__in=[41,42])

    def has_add_permission(self):
        return False

    def has_update_permission(self):
        return True

    def has_change_permission(self, request=None):
        return True

    def has_delete_permission(self, request=None):
        return False

    def has_save_permission(self, request=None):
        return True

    def save_models(self):
        obj = self.new_obj

        if obj.refund_status == 42 and obj.handle_status=="已收到货，进行退款" :

            # 获取订单详情
            orderDetail = OrderInfoDetail.objects.get(id=obj.returnOrderDetail.id)
            # 获取订单详情
            order = OrderInfo.objects.get(id=orderDetail.order.id)

            ch = pingpp.Charge.retrieve(order.pay_sn)
            re = ch.refunds.create(description=' Description', amount=int(orderDetail.product.shop_price*100))

            channel = 'wx'
            if order.pay_type == 1:
                channel = 'alipay'
            print(re)
            receipt_body = json.dumps(re)
            print(receipt_body)
            receipt_json = json.loads(receipt_body)
            receipt = PaymentReceipt(pay_id=receipt_json['id'], receipt_body=receipt_body,
                                     user=self.request.user,type='return',orderDetailId=orderDetail.id,
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


class OrderInfoCancelReceiptAdmin(object):
    list_display = ["order", "reason", "add_time"]
    readonly_fields = ['order', 'reason', 'add_time']
    model_icon = 'fa fa-th-list'
    can_delete = False
    can_add = False
    can_update = False

    def queryset(self):
        qs = super(OrderInfoCancelReceiptAdmin, self).queryset()
        return qs.filter(is_cancel=1)

    def has_add_permission(self):
        return False

    def has_update_permission(self):
        return True

    def has_change_permission(self, request=None):
        return True

    def has_delete_permission(self, request=None):
        return False

    def has_save_permission(self, request=None):
        return True

    def save_models(self):
        obj = self.new_obj

        if obj.handle_result=="同意退款" :
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
            receipt = PaymentReceipt(pay_id=receipt_json['id'], receipt_body=receipt_body, user=self.request.user,
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


class AlipayReturnWebhookEventAdmin(object):
    list_display = ["pay_id", "orderDetail", "status", "add_time"]
    readonly_fields = ["status", "pay_id", "URL", "order", "add_time", "webhook_message"]
    list_filter = ['status']
    exclude = ['pay_status']  # 隐藏状态
    model_icon = 'fa fa-th-list'
    can_delete = False
    can_add = False
    can_update = False

    def URL(self, obj):
        if obj.status == 0:
            alipay_url = obj.webhook_message.get("failure_msg")[obj.webhook_message.get("failure_msg").index('https'):]
            return '<a href="%s" target="_blank">%s</a>' % (alipay_url, "支付宝支付")
        else:
            return "退款完成"

    URL.allow_tags = True
    URL.short_description = '支付宝支付'

    def queryset(self):
        qs = super(AlipayReturnWebhookEventAdmin, self).queryset()
        return qs

    def has_add_permission(self):
        return False

    def has_update_permission(self):
        return False

    def has_change_permission(self, request=None):
        return True

    def has_delete_permission(self, request=None):
        return False

    def has_save_permission(self, request=None):
        return False

    def get_readonly_fields(self):
        return [f.name for f in self.model._meta.fields]

    def save_models(self):
        obj = self.new_obj


class AlipayCancelWebhookEventAdmin(object):
    list_display = ["pay_id", "order", "status", "add_time"]
    readonly_fields = ["status", "pay_id", "URL", "order", "add_time","webhook_message"]
    list_filter = ['status']
    exclude = ['pay_status']  # 隐藏状态
    model_icon = 'fa fa-th-list'
    can_delete = False
    can_add = False
    can_update = False

    def URL(self, obj):
        if obj.status == 0:
            alipay_url = obj.webhook_message.get("failure_msg")[obj.webhook_message.get("failure_msg").index('https'):]
            return '<a href="%s" target="_blank">%s</a>' % (alipay_url, "支付宝支付")
        else:
            return "退款完成"

    URL.allow_tags = True
    URL.short_description = '支付宝支付'

    def queryset(self):
        qs = super(AlipayCancelWebhookEventAdmin, self).queryset()
        return qs

    def has_add_permission(self):
        return False

    def has_update_permission(self):
        return False

    def has_change_permission(self, request=None):
        return True

    def has_delete_permission(self, request=None):
        return False

    def has_save_permission(self, request=None):
        return False

    def save_models(self):
        obj = self.new_obj



xadmin.site.register(ShoppingCart, ShoppingCartAdmin)
xadmin.site.register(OrderInfo, OrderInfoAdmin)
xadmin.site.register(OrderInfoReturnGoodsReceipt, OrderInfoReturnGoodsReceiptAdmin)
xadmin.site.register(OrderInfoShopShipping, OrderInfoShopShippingAdmin)
xadmin.site.register(OrderInfoRefundReceipt, OrderInfoRefundReceiptAdmin)
xadmin.site.register(OrderInfoCancelReceipt, OrderInfoCancelReceiptAdmin)
xadmin.site.register(AlipayReturnWebhookEvent, AlipayReturnWebhookEventAdmin)
xadmin.site.register(AlipayCancelWebhookEvent, AlipayCancelWebhookEventAdmin)
