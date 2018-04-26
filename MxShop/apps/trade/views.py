import time
from datetime import datetime
from rest_framework import viewsets, status
from rest_framework.permissions import IsAuthenticated
from rest_framework_jwt.authentication import JSONWebTokenAuthentication
from rest_framework.authentication import SessionAuthentication,TokenAuthentication
from rest_framework import mixins
from django.shortcuts import redirect
from django.http import QueryDict



from .serializers import ShopCartSerializer, OrderDetailSerializer, ShopCartDetailSerializer, OrderSerializer, OrderListSerializer
from utils.permissions import IsOwnerOrReadOnly
from .models import ShoppingCart, OrderInfo, OrderGoods

from goods.models import Goods


class ShoppingCartViewset(viewsets.ModelViewSet):
    """
    购物车功能
    list:
        获取购物车详情
    create：
        加入购物车
    delete：
        删除购物记录
    """
    permission_classes = (IsAuthenticated, IsOwnerOrReadOnly)
    authentication_classes = (
        JSONWebTokenAuthentication,
        SessionAuthentication,TokenAuthentication)
    serializer_class = ShopCartSerializer
    lookup_field = "goods_id"

    # lookup_fields = ("goods_id",'id','pk')
    def qdict_to_dict(self, qdict):
        if isinstance(qdict, QueryDict):
            return {k: v[0] if len(v) == 1 else v for k, v in qdict.lists()}
        elif isinstance(qdict, dict):
            return qdict

    def get_queryset(self):
        return ShoppingCart.objects.filter(
            user=self.request.user).filter(
            status="0")
    # queryset = ShoppingCart.objects.all()

    def get_serializer_class(self):
        if self.action == 'list':
            return ShopCartDetailSerializer
        else:
            return ShopCartSerializer
    # serializer_class = ShopCartSerializer

    def create(self, request, *args, **kwargs):
        data = request.data  # QueryDict
        # user = self.request.user
        data = self.qdict_to_dict(data)
        nums = data.get('nums', 1)
        nums = nums if isinstance(nums, int) else int(nums)
        good = Goods.objects.filter(id=data.get('goods'))[0]
        goods_num = good.goods_num
        if good and goods_num >= 1 and goods_num >= nums:
            # data['user'] = user
            data['goods'] = good.id  # 注意是主键 不是model
            # good.goods_num -= nums #在支付后 才改变状态
            # good.save()
            serializer = ShopCartSerializer(
                data=data, context={"request": self.request})
            if serializer.is_valid():
                serializer.save()  # 调用serializer.create()
                return Response(serializer.data, status=status.HTTP_200_OK)
            return Response(
                serializer.errors,
                status=status.HTTP_400_BAD_REQUEST)
        return Response(data='不好意思,库存数量不足', status=status.HTTP_400_BAD_REQUEST)

    # def perform_create(self, serializer):
    #     shop_cart = serializer.save()  # serializer的create()会跳转到这里
        # goods = shop_cart.goods
        # goods_num =  goods.goods_num
        # if goods_num < 1:
        # return
        # print('商品还有的数量:' ,goods_num)
        # print('我购买的数量',shop_cart.nums)
     #    # shop_cart.nums 已经是累加的数量了,不是当时想要购买的数量,显示的还是总数
        # nums = serializer._validated_data.get('nums',1)
        # print(nums)
        # goods.goods_num -= nums
    #     # goods.goods_num -= shop_cart.nums
        # print('购买之后还有多少商品数量:' ,goods.goods_num)
        # goods.save() # 跳转到 mixins的perform_create()

# 删除的第一种方式
    # 虽然还是重写的 mixins.DestroyModelMixin的destroy 但如果没有generics.DestroyAPIView则不会有delete这个权限
    # def destroy(self,request,*args,**kwargs): # delete
    #     pk= request.query_params.get('pk','')
    #     instance = ShoppingCart.objects.filter(id=pk) # QuerySet []
    #     if instance:
    #         # self.perform_destroy(instance) #为了显示删除的对象 就不能用这个
    #         instance =  instance[0]
    #         goods = instance.goods
    #         goods.goods_num += instance.nums
    #         goods.save()
    #         serializer =   ShopCartSerializer(instance)
    #         instance.delete()
    #         return Response(serializer.data,status=status.HTTP_200_OK)
    #     return Response(status=status.HTTP_400_BAD_REQUEST)

# 删除的第二种方式
    # get_object()二选一
    # def get_object(self):
        # request = self.request
        # pk = request.query_params.get('pk', '')
        # return ShoppingCart.objects.filter(id=pk)[0]


    # def get_object(self):
        # queryset = self.filter_queryset(self.get_queryset())
        # make sure to catch 404's below
        # request = self.request
        # request = request._request
        # get = request.GET
        # pk = get.get('pk')
        # pk = pk[0]
        # obj = queryset.get(pk=pk)
        # self.check_object_permissions(self.request, obj)
        # return obj

    # def perform_update(self, serializer):
        # saved_record = serializer.save()
        # existed_record = ShoppingCart.objects.get(id=serializer.instance.id)
        # existed_num = existed_record.nums
        # nums = saved_record.nums - existed_num
        # goods = saved_record.goods
        # goods.goods_num -= nums
        # goods.save()


class OrderViewset(
        mixins.ListModelMixin,
        mixins.RetrieveModelMixin,
        mixins.CreateModelMixin,
        mixins.DestroyModelMixin,
        viewsets.GenericViewSet):
    """
    订单管理
    list:
        获取个人订单
    delete:
        删除订单
    create：
        新增订单
    """
    permission_classes = (IsAuthenticated, IsOwnerOrReadOnly)
    authentication_classes = (
        JSONWebTokenAuthentication,
        TokenAuthentication,
        SessionAuthentication)
    # 可有可无:
    # serializer_class = OrderSerializer

    def get_queryset(self):
        return OrderInfo.objects.filter(user=self.request.user)

    def get_serializer_class(self):
        if self.action == 'retrieve':
            return OrderDetailSerializer
        elif self.action == 'list':  # GET()
            return OrderListSerializer
        return OrderSerializer

    def perform_create(self, serializer):
        shop_carts = ShoppingCart.objects.filter(
            user=self.request.user).filter(status='0')
        if not shop_carts:
            return
        total_price = 0
        auth_shop_nums = 0  # 认证购物车中 商品的数量
        shop_nums = len(shop_carts)
        for item in shop_carts:
            goods_num = item.goods.goods_num  # 库存数量
            cart_nums = item.nums  # 购物车中的数量
            if goods_num >= cart_nums:
                auth_shop_nums += 1

        if auth_shop_nums != shop_nums:
            return
        else:
            order = serializer.save()
            for item in shop_carts:
                order_goods = OrderGoods()
                order_goods.goods = item.goods
                order_goods.goods_num = cart_nums
                order_goods.order = order
                total_price += order_goods.goods.shop_price * cart_nums
                order_goods.save()
                # 不在这里删除,而是在支付成功之后删除
                # 这里只是需要把购物车商品的状态 多加一个待支付的状态
                # item.delete()
                item.status = "1"
                item.save()
            order.order_amount = total_price
            order.save()
        return order

    # def get_object(self):
        # request = self.request
        # pk= request.query_params.get('pk','')
        # return  OrderInfo.objects.filter(id = pk)[0]

    # def perform_destroy(self, instance):
        # order_goods = instance.goods
        # for oreder_good in order_goods :
        # good = oreder_good.get('goods')
        # good.goods_num += oreder_good.get('goods_num',1)
        # good.save()
        # instance.delete()
    def destroy(self, request, *args, **kwargs):
        # pk= request.query_params.get('pk','')
        pk = kwargs.get('pk')
        instance = OrderInfo.objects.filter(id=pk)  # QuerySet []
        serializer = OrderSerializer(instance)
        instance = instance[0]
        if instance:
            # 这里不去改变库存数量,而是改变购物车的状态
            # order_goods = instance.goods.all()
            # for order_good in order_goods :
                # good = order_good.goods
                # good.goods_num += order_good.goods_num
                # good.save()
            instance.delete()
            shop_carts = ShoppingCart.objects.filter(user=self.request.user)
            for item in shop_carts:
                item.status = "0"
                item.save()
            serializer = OrderSerializer(instance)
            return Response(serializer.data, status=status.HTTP_200_OK)
        return Response(status=status.HTTP_400_BAD_REQUEST)


from rest_framework.views import APIView
from utils.alipay import AliPay
from MxShop.settings import ali_pub_key_path, private_key_path
from rest_framework.response import Response


class AlipayView(APIView):
    def get(self, request):
        """
        处理支付宝的return_url返回
        :param request:
        :return:
        """
        processed_dict = {}
        for key, value in request.GET.items():
            processed_dict[key] = value

        sign = processed_dict.pop("sign", None)

        alipay = AliPay(
            appid="",
            app_notify_url="http://127.0.0.1:8000/alipay/return/",
            app_private_key_path=private_key_path,
            alipay_public_key_path=ali_pub_key_path,  # 支付宝的公钥，验证支付宝回传消息使用，不是你自己的公钥,
            debug=True,  # 默认False,
            return_url="http://127.0.0.1:8000/alipay/return/"
        )

        verify_re = alipay.verify(processed_dict, sign)

        if verify_re is True:
            order_sn = processed_dict.get('out_trade_no', None)
            trade_no = processed_dict.get('trade_no', None)
            trade_status = processed_dict.get('trade_status', None)

            existed_orders = OrderInfo.objects.filter(order_sn=order_sn)
            for existed_order in existed_orders:
                existed_order.pay_status = trade_status
                existed_order.trade_no = trade_no
                existed_order.pay_time = datetime.now()
                existed_order.save()

            response = redirect("index")
            response.set_cookie("nextPath", "pay", max_age=3)
            return response
        else:
            response = redirect("index")
            return response

    def post(self, request):
        """
        处理支付宝的notify_url
        :param request:
        :return:
        """
        processed_dict = {}
        for key, value in request.POST.items():
            processed_dict[key] = value

        sign = processed_dict.pop("sign", None)

        alipay = AliPay(
            appid="",
            app_notify_url="http://127.0.0.1:8000/alipay/return/",
            app_private_key_path=private_key_path,
            alipay_public_key_path=ali_pub_key_path,  # 支付宝的公钥，验证支付宝回传消息使用，不是你自己的公钥,
            debug=True,  # 默认False,
            return_url="http://127.0.0.1:8000/alipay/return/"
        )

        verify_re = alipay.verify(processed_dict, sign)

        if verify_re is True:
            order_sn = processed_dict.get('out_trade_no', None)
            trade_no = processed_dict.get('trade_no', None)
            trade_status = processed_dict.get('trade_status', None)

            existed_orders = OrderInfo.objects.filter(order_sn=order_sn)
            for existed_order in existed_orders:
                order_goods = existed_order.goods.all()
                for order_good in order_goods:
                    goods = order_good.goods
                    goods.sold_num += order_good.goods_num
                    goods.save()

                existed_order.pay_status = trade_status
                existed_order.trade_no = trade_no
                existed_order.pay_time = datetime.now()
                existed_order.save()

            return Response("success")
