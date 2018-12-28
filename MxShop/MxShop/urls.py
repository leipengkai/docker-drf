"""MxShop URL Configuration

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/1.11/topics/http/urls/
Examples:
Function views
    1. Add an import:  from my_app import views
    2. Add a URL to urlpatterns:  url(r'^$', views.home, name='home')
Class-based views
    1. Add an import:  from other_app.views import Home
    2. Add a URL to urlpatterns:  url(r'^$', Home.as_view(), name='home')
Including another URLconf
    1. Import the include() function: from django.conf.urls import url, include
    2. Add a URL to urlpatterns:  url(r'^blog/', include('blog.urls'))
"""
from filebrowser.sites import site
from django.conf.urls import url, include
import xadmin
from .settings import MEDIA_ROOT,STATIC_URL,STATIC_ROOT
from django.contrib import admin
from django.views.static import serve
from rest_framework.documentation import include_docs_urls
from rest_framework.routers import DefaultRouter
from rest_framework.authtoken import views
from rest_framework_jwt.views import obtain_jwt_token
import debug_toolbar
from django.conf import settings
from django.conf.urls.static import static


from goods.views import GoodsListViewSet, CategoryViewset, HotSearchsViewset, BannerViewset, GoodsSimpleListViewSet
from goods.views import IndexCategoryViewset, GoodsSimpleListview, GoodsCommentListViewSet,GoodsDetailViewSet
from users.views import SmsCodeViewset, UserViewset
from user_operation.views import UserFavViewset, LeavingMessageViewset, AddressViewset, CheckInViewSet
from trade.views import ShoppingCartViewset, OrderViewset
from goods.views_base import GoodsListView

router = DefaultRouter()

# 配置goods的url
router.register(r'goods', GoodsListViewSet, base_name="goods")


# 配置category的url
router.register(r'categorys', CategoryViewset, base_name="categorys")
# http:127.0.0.1:8000/categorys/1/ 具体的一个

router.register(r'codes', SmsCodeViewset, base_name="codes")

router.register(r'hotsearchs', HotSearchsViewset, base_name="hotsearchs")

router.register(r'user', UserViewset, base_name="user")

# 收藏
router.register(r'userfavs', UserFavViewset, base_name="userfavs")

# 留言
router.register(r'messages', LeavingMessageViewset, base_name="messages")

# 收货地址
router.register(r'address', AddressViewset, base_name="address")

# 购物车url
router.register(r'shopcarts', ShoppingCartViewset, base_name="shopcarts")

# 订单相关url
router.register(r'orders', OrderViewset, base_name="orders")

# 轮播图url
router.register(r'banners', BannerViewset, base_name="banners")

# 首页商品系列数据
router.register(r'indexgoods', IndexCategoryViewset, base_name="indexgoods")

# 商品评论
router.register(r'goodsComment', GoodsCommentListViewSet, base_name='goodsComment')

# 用户签到
router.register(r'checkin', CheckInViewSet, base_name='checkin')

# goods_list = GoodsListViewSet.as_view({
# 'get': 'list',
# })

# 动态绑定
router.register(
    r'simplegoodsset',
    GoodsSimpleListViewSet,
    base_name="simplegoodsset")


# 手动绑定
goods_simple_list = GoodsSimpleListViewSet.as_view({
    'get': 'list',
})

from trade.views import AlipayView
from django.views.generic import TemplateView
urlpatterns = [
    # url('admin/filebrowser/', site.urls), # grappelli URLS

    # url(r'^grappelli/', include('grappelli.urls')), # grappelli URLS

    url(r'^jet/', include('jet.urls', 'jet')),  # Django JET URLS

    url(r'^jet/dashboard/', include('jet.dashboard.urls',
                                    'jet-dashboard')),  # Django JET dashboard URLS

    url(r'^admin/', admin.site.urls),

    # url(r'^xadmin/', xadmin.site.urls),

    url(r'^api-auth/', include('rest_framework.urls', namespace='rest_framework')),

    url(r'^media/(?P<path>.*)$', serve, {"document_root": MEDIA_ROOT}),
    url(r'^static/(?P<path>.*)$', serve, {"document_root": STATIC_ROOT}),
    # url(r'^static/(?P<path>.*)$', serve, {"document_root": STATIC_URL}),

    url(r'^api/v1/', include(router.urls)),  # router注册的APIh

    url(r'^index/', TemplateView.as_view(template_name="index.html"), name="index"),

    url(r'docs/', include_docs_urls(title="慕学生鲜")),

    # drf自带的token认证模式
    url(r'^api-token-auth/', views.obtain_auth_token),

    # jwt的认证接口
    url(r'^auth/login/$', obtain_jwt_token),

    url(r'^alipay/return/', AlipayView.as_view(), name="alipay"),

    ###########################################################################
    url(r'^goodsbase/$', GoodsListView.as_view()),

    url(r'^goodssimple/$', GoodsSimpleListview.as_view()),
    url(r'^simplegoodsset/$', goods_simple_list),

    # url(r'^detail/(?P<pk>\d+)/$',GoodsDetailViewSet.as_view({'get':'retrieve'})),
    # url(r'^detail/(?P<pk>\d+)/$',GoodsDetailViewSet.as_view()),
    url(r'^detail/(?P<pk>\d+)/$',GoodsDetailViewSet.detail),
    
    # 第三方登录 social_login
    url('', include('social_django.urls', namespace='social')),

    # 性能分析工具
    url(r'^__debug__/', include(debug_toolbar.urls)),
# ]+ static(settings.STATIC_URL, document_root = settings.STATIC_ROOT)
]
