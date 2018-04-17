from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework import mixins
from rest_framework import generics
from rest_framework import filters
from rest_framework.pagination import PageNumberPagination
from django_filters.rest_framework import DjangoFilterBackend
from rest_framework import viewsets
from rest_framework.authentication import TokenAuthentication
from rest_framework.throttling import UserRateThrottle, AnonRateThrottle
from rest_framework.authentication import TokenAuthentication
from rest_framework.permissions import IsAuthenticated

from rest_framework_extensions.cache.mixins import CacheResponseMixin

from .models import Goods, GoodsCategory, HotSearchWords, Banner, GoodsComment
from .filters import GoodsFilter, GoodsCommentFilter
from .serializers import GoodsSerializer, CategorySerializer, HotWordsSerializer, BannerSerializer
from .serializers import IndexCategorySerializer, GoodsSimpleSerializer, GoodsCommentSerializer
# Create your views here.


class GoodsPagination(PageNumberPagination):
    page_size = 8
    page_size_query_param = 'page_size'
    page_query_param = "page"
    max_page_size = 100


class GoodsListViewSet(
        CacheResponseMixin,
        mixins.ListModelMixin,
        mixins.RetrieveModelMixin,
        viewsets.GenericViewSet):
    """
    商品列表页, 分页， 搜索， 过滤， 排序
    """
    # throttle_classes = (UserRateThrottle, )
    queryset = Goods.objects.all()
    serializer_class = GoodsSerializer
    pagination_class = GoodsPagination
    # authentication_classes = (TokenAuthentication, )
    filter_backends = (
        DjangoFilterBackend,
        filters.SearchFilter,
        filters.OrderingFilter)
    filter_class = GoodsFilter
    search_fields = ('name', 'goods_brief', 'goods_desc')
    ordering_fields = ('sold_num', 'shop_price')

    def retrieve(self, request, *args, **kwargs):
        instance = self.get_object()
        instance.click_num += 1
        instance.save()
        serializer = self.get_serializer(instance)
        return Response(serializer.data)


class CategoryViewset(
        CacheResponseMixin,
        mixins.ListModelMixin,
        mixins.RetrieveModelMixin,
        viewsets.GenericViewSet):
    """
    list:
        商品分类列表数据
    retrieve:
        获取商品分类详情
    """
    queryset = GoodsCategory.objects.filter(category_type=1)
    serializer_class = CategorySerializer


class HotSearchsViewset(mixins.ListModelMixin, viewsets.GenericViewSet):
    """
    获取热搜词列表
    """
    queryset = HotSearchWords.objects.all().order_by("-index")
    serializer_class = HotWordsSerializer


class BannerViewset(mixins.ListModelMixin, viewsets.GenericViewSet):
    """
    获取轮播图列表
    """
    queryset = Banner.objects.all().order_by("index")
    serializer_class = BannerSerializer


class IndexCategoryViewset(mixins.ListModelMixin, viewsets.GenericViewSet):
    """
    首页商品分类数据
    """
    queryset = GoodsCategory.objects.filter(
        is_tab=True, name__in=["生鲜食品", "酒水饮料"])
    serializer_class = IndexCategorySerializer

class GoodsCommentListViewSet(mixins.ListModelMixin,mixins.RetrieveModelMixin, viewsets.GenericViewSet):
    '''
    商品评论
    '''
    throttle_classes = (UserRateThrottle, AnonRateThrottle)
    serializer_class =  GoodsCommentSerializer
    queryset =  GoodsComment.objects.all()
    pagination_class = GoodsPagination
    filter_backends = (DjangoFilterBackend, filters.SearchFilter, filters.OrderingFilter)
    filter_class = GoodsCommentFilter
    search_fields = ('goods_id',)
    ordering_fields = ('id',)

    # 如果在这里创建的话 ,就需要权限
    # def get_permissions(self):
        # if self.action == "retrieve":
            # return []
        # elif self.action == "list":
            # return []
        # elif self.action == "create":
            # return [IsAuthenticated()]
        # return []

###########################################################################
# class GoodsSimpleListview(APIView):
    # """
    # List goodssimple
    # """

    # # authentication_classes = (authentication.TokenAuthentication,) # 认证
    # # permission_classes = (permissions.IsAdminUser,) # 权限(只有admin用户才能访问这个View)
    # # throttle_classes = (UserRateThrottle, AnonRateThrottle) # 节流(认证用户/ 匿名用户访问频率)

    # # authentication_classes = (JSONWebTokenAuthentication, SessionAuthentication)
# rest_framework.authentication.BasicAuthentication 如果使用这种认证模式的话,会弹出登陆页面
# 多种认证只需要一种通过就行了,JWT没有通过则用后面的Session模式通过,session模式会在浏览器中生成crsftoken并保存一个sessionid到cookie中

    # def get(self, request, format=None):
    # goods =  Goods.objects.all()
    # serializer =  GoodsSimpleSerializer(goods , many=True)
    # return Response(serializer.data)

class GoodsSimpleListview(mixins.ListModelMixin, generics.GenericAPIView):
    queryset = Goods.objects.all()
    serializer_class = GoodsSimpleSerializer
    pagination_class = GoodsPagination
    # filter_backends,
    # lookup_field

    # 手动绑定 如果没有写get() 默认就不接受GET请求 则会有此信息:方法 “GET” 不被允许
    def get(self, request, *args, **kwargs):
        return self.list(request, *args, **kwargs)

    # 自动组合绑定
# class GoodsSimpleListview(generics.ListCreateAPIView):
    # queryset =Goods.objects.all()
    # serializer_class = GoodsSimpleSerializer

    # 通过url进行绑定,可动态绑定 但也要有mixins的对应操作 才能有对应的请求
# class GoodsSimpleListViewSet(mixins.ListModelMixin,viewsets.GenericViewSet):

    # queryset =Goods.objects.all()
    # serializer_class =   GoodsSimpleSerializer
    # pagination_class = GoodsPagination

    # 组合的形式


class GoodsSimpleListViewSet(viewsets.ReadOnlyModelViewSet):
    # class GoodsSimpleListViewSet(viewsets.ModelViewSet):  #即使有mixins.DestroyModelMixin ,也没有明显的删除按钮
    # class
    # GoodsSimpleListViewSet(viewsets.ModelViewSet,generics.DestroyAPIView):

    queryset = Goods.objects.all()
    serializer_class = GoodsSimpleSerializer
    # serializer_class =  GoodsSerializer
    pagination_class = GoodsPagination

# 相等查询 django-filter包
    # filter_backends = (DjangoFilterBackend,)
    # filter_fields = ('name', 'shop_price')

# 自定义搜索模式 需要依赖django-filter 字段重复会覆盖掉上面的过滤
    # filter_class =  GoodsFilter

# drf

    authentication_classes = (TokenAuthentication,)  # 认证
    filter_backends = (
        DjangoFilterBackend,
        filters.SearchFilter,
        filters.OrderingFilter)
    filter_class = GoodsFilter
    search_fields = ('name', 'goods_brief', 'goods_desc')
    ordering_fields = ('sold_num', 'shop_price')
    # def get_queryset(self):
    # queryset =Goods.objects.all()
    # price_min = self.request.query_params.get("price_min",0)
    # # 根本就不需要将price_min加入到 lookup_field中啊
    # if price_min:
    # queryset = queryset.filter(shop_price__gt=int(price_min))
    # return queryset

    # def get_object(self):
        # request = self.request
        # pk= request.query_params.get('pk','')
        # return  OrderInfo.objects.filter(id = pk)[0]

    # def get_serializer_class(self):
        # if self.action == 'retrieve':
            # return OrderDetailSerializer
        # elif self.action == 'list': # GET()
            # return OrderListSerializer
        # return OrderSerializer

    # def get_permissions(self):
        # if self.action == "retrieve":
            # return [permissions.IsAuthenticated()]
        # elif self.action == "list":
            # return [permissions.IsAdminUser()]
        # elif self.action == "create":
            # return []
        # return []

# def perform_create(self, serializer): # 改变保存这个serializer之后,要处理的逻辑,也可以用signals来处理,数据库的数据已经保存
    # serializer._validated_data 得到传递的参数
    #instance = serializer.save() 
    #goods = instance.goods
    #goods.fav_num += 1
    #goods.save()

# def create(self, request, *args, **kwargs): # 应该是自定义返回给前端的内容
    # return Response(re_dict, status=status.HTTP_201_CREATED, headers=headers)

# def retrieve(self, request, *args, **kwargs): # 处理展示的状态
    # instance = self.get_object() 
    # userMembershipInfo = instance.membershipInfo
