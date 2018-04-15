from django.test import TestCase
from django.urls import reverse
from django.test.utils import override_settings
from django.conf import settings

# import django
# django.setup()

import os
import sys
# from filebrowser.sites import site
# Build paths inside the project like this: os.path.join(BASE_DIR, ...)
# BASE_DIR = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
# 将应用包加入系统变量，便于模块导入
# sys.path.insert(0, BASE_DIR)
# sys.path.insert(0, os.path.join(BASE_DIR, 'goods'))
# os.environ.setdefault("DJANGO_SETTINGS_MODULE", "MxShop.settings")

from goods.models import Goods, GoodsCategory

# Create your tests here.
class GoodsListViewTestCase(TestCase):

    @classmethod
    def setUpTestData(cls):
        goodscategory = GoodsCategory.objects.create(category_type=1,name=1)
        number_goods = 12
        for goods in range(number_goods):
            g = Goods.objects.create(name='{}'.format(goods),goods_brief='{good}:brief'.format(good=goods),
                                 category=goodscategory)
            g.save()


    # @override_settings(DEBUG=True)
    # def test_debug(self):
        # # assert settings.DEBUG
        # self.assertTrue(settings.DEBUG)

    def test_view_url_exists_at_desired_location(self): 
        '''
        视图可以通过正确的URL进行访问
        '''

        resp = self.client.get('/goods/') 
        self.assertEqual(resp.status_code, 200)
        resp = self.client.get('/goods/'+'?page=2') 
        self.assertEqual(resp.status_code, 200)
        resp = self.client.get('/goods/'+'?search=1') 
        self.assertEqual(resp.status_code, 200)
