import re

from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework import mixins
from rest_framework import generics
from rest_framework import filters
from rest_framework.pagination import PageNumberPagination
from django_filters.rest_framework import DjangoFilterBackend
from rest_framework import viewsets
from rest_framework.throttling import UserRateThrottle, AnonRateThrottle
from rest_framework.authentication import TokenAuthentication
from rest_framework.permissions import IsAuthenticated
from django.template import loader, RequestContext
from django.shortcuts import render_to_response
from django.http import HttpResponse

from rest_framework_extensions.cache.mixins import CacheResponseMixin
from django.shortcuts import render


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
        is_tab=True,
        # name__in=["生鲜食品", "酒水饮料"]
    )
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

# class GoodsDetailViewSet(mixins.RetrieveModelMixin, viewsets.GenericViewSet):
# class GoodsDetailViewSet(mixins.RetrieveModelMixin, generics.GenericAPIView):

class GoodsDetailViewSet(mixins.RetrieveModelMixin, viewsets.GenericViewSet):

    # def ip_address_processor(request):
            # return {'ip_address': request.META['REMOTE_ADDR']}
    def detail(request,pk):
        queryset = Goods.objects.filter(id=pk)[0]
        images = queryset.images.model.objects.filter(goods=queryset)
        goods_desc = queryset.goods_desc 
        goods_desc = re.sub('(src=".*?")',r'\1 class="img-responsive"',goods_desc)
        g = Goods.objects.get(id=pk)
        spec = g.spec.all() # 多对多正向查询 此商品所有规格
        spec_value_list,sku_value_list =[],[]
        for specmodel in spec:
            all_value = specmodel.specvalue.all() # 一对多反向查询:SpecValue的小写形式,并且不需要加_set
            for specvaluemodel in all_value:
                # if specmodel == specvaluemodel.spec:
                spec_value_list.append({"id":specmodel.id,"name":specmodel.name,"value":specvaluemodel.value})

        sku = g.sku.all() # 一对多反向查询:sku的小写形式. 此商品的所有sku
        for skumodel in sku:
            all_sku_value = skumodel.skuvalue.all() # 一对多反向查询:SKUValue的小写形式
            sku_ifno = {"id":skumodel.id,"name":skumodel.name,"price":skumodel.price,"stock":skumodel.stock,"cont":[]}
            for skuvaluemodel in all_sku_value:
                # if skumodel == skuvaluemodel.sku:
                sku_ifno["cont"].append({
                    "spec_id":skuvaluemodel.specvalue.spec.id,
                    "spec_name":skuvaluemodel.specvalue.spec.name,
                    "specvalue_id":skuvaluemodel.specvalue.id,
                    "specvalue_name":skuvaluemodel.specvalue.value,
                                    })
            sku_value_list.append(sku_ifno)

        print(spec_value_list)
        print(sku_value_list)


        return render(request,'detail.html',{'goods':queryset,'images':images,'goods_desc':goods_desc})


        # t = loader.get_template('detail.html')
        # context =  RequestContext(request,{'goods':queryset,'images':images})
        # return  HttpResponse(t.render({'goods':queryset,'images':images}))

class WeiboLoginViewSet(viewsets.GenericViewSet):




    def login(request):
        """
            client_id   必填  string  申请应用时分配的App Key。
            redirect_uri    必填  string  授权回调地址，站外应用需与设置的回调地址一致。
        """
        from django.conf import settings
        client_id = settings.SOCIAL_AUTH_WEIBO_KEY
        client_secret = settings.SOCIAL_AUTH_WEIBO_SECRET
        weibo_auth_url = 'https://api.weibo.com/oauth2/authorize'
        redirect_uri = "http://127.0.0.1/complete/weibo/"
        auth_url = weibo_auth_url + "?client_id={client_id}&redirect_uri={re_url}".format(client_id=client_id,
                                                                                          re_url=redirect_uri)
        return render(request,'weibologin.html',{"auth_url":auth_url})

    def get_access_token(request):
        access_token_url = "https://api.weibo.com/oauth2/access_token"

        import requests
        from django.conf import settings
        client_id = settings.SOCIAL_AUTH_WEIBO_KEY
        client_secret = settings.SOCIAL_AUTH_WEIBO_SECRET
        code = request.GET.get("code")
        re_dict = requests.post(access_token_url, data={
            "client_id": client_id,
            # App Secret
            "client_secret": client_secret,
            "grant_type": "authorization_code",
            "code": code ,
            "redirect_uri": "http://127.0.0.1/complete/weibo/",
        })
        print(re_dict)
        pass

    def get_user_info(self,access_token):
        user_url = "https://api.weibo.com/2/users/show.json"
        uid = "5020302235"
        get_url = user_url + "?access_token={at}&uid={uid}".format(at=access_token, uid=uid)
        print(get_url)

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
    # ViewSet,generics不能一起使用,不然在OPTIONS操作时会报错

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
    # 一个的时候一定要用单数 search_field = ('name')  or  search_fields = ('name',)
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
    # def get_object(self):
        # return self.request.user

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
    # serializer.data.get("username") # 已经保存的信息
    # data = serializer._validated_data 得到传递的参数 这个也应该是: self.request.data.get('goodsList')
    # nums = data.get('nums')
    #instance = serializer.save() 
    #goods = instance.goods
    #goods.fav_num += 1
    #goods.save()

# def create(self, request, *args, **kwargs): # 应该是自定义返回给前端的内容
    # self.request.data.get('goodsList')  前端使用表单传递
    # serializer = self.get_serializer(data=request.data)
    # re_dict = serializer.data
    # return Response(re_dict, status=status.HTTP_201_CREATED, headers=headers)

# def retrieve(self, request, *args, **kwargs): # 处理展示的状态
    # instance = self.get_object() 
    # userMembershipInfo = instance.membershipInfo
