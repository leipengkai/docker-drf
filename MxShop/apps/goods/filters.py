# -*- coding: utf-8 -*-
__author__ = 'bobby'

import django_filters
from django.db.models import Q

from .models import Goods,GoodsComment


class GoodsFilter(django_filters.rest_framework.FilterSet):
    """
    商品的过滤类
    """
    pricemin = django_filters.NumberFilter(
        name='shop_price', help_text="最低价格", lookup_expr='gte')

    pricemax = django_filters.NumberFilter(
        name='shop_price', help_text="最高价格", lookup_expr='lte')
    
    name = django_filters.CharFilter(
        name='name',
        lookup_expr='icontains',
        help_text="商品名称(全局模糊搜索)")

    top_category = django_filters.NumberFilter(
        name='category',
        method='top_category_filter',
        help_text="类目等级:1,2,3")

    def top_category_filter(self, queryset, name, value):
        return queryset.filter(Q(category_id=value) | Q(category__parent_category_id=value) |
                               Q(category__parent_category__parent_category_id=value))

    class Meta:
        model = Goods
        fields = ['pricemin', 'pricemax', 'is_hot', 'is_new', 'name']


class GoodsCommentFilter(django_filters.rest_framework.FilterSet):
    goods_id = django_filters.NumberFilter(name='goods_id', help_text='所属商品')
    class Meta:
        model = GoodsComment
        fields = ['goods_id']

