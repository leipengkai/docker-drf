from django.test import TestCase,client
from rest_framework.test import APITestCase
from rest_framework import status
from rest_framework.test import APIClient
from django.contrib.auth import get_user_model
from django.contrib.auth import login

from users.models import UserProfile

User = get_user_model()


class UsersTestCase(TestCase):

    @classmethod
    def setUpTestData(cls):
        '''
        测试运行开始时调用一次 用来创建不会在任何测试方法中修改或更改的对象
        '''
        print("setUpTestData: Run once to set up non-modified data for all class methods.")

        cls.data= {'username':'femn','password':'111111','email':'femn@gmail.com'}
        cls.user = User.objects.create(**cls.data)
    def setUp(self):
        '''
        在每个测试函数之前被调 用来设置任何可能被测试修改的对象
        '''

        print("setUp: Run once for every test method to setup clean data.")

        # 遇到用户登陆的坑
        # login(user=self.user)


        # UserProfile.objects.create_user(username='femn', password='111111')
        # response = client.Client.login(username='femn',password='111111')

        # client = APIClient()
        # client.post('/api-auth/login/',{'username':'femn','password':'111111'})
        # client.login(username='femn', password='111111')

        # response = self.client.login(username='femn',password='111111')
        # response = self.client.login(self.user)

        # self.assertEquals(response,True)


    # MODEL
    def test_first_name_max_length(self):
        users = UserProfile.objects.get(username='femn')
        max_length = users._meta.get_field('username').max_length
        self.assertEquals(max_length,30)
        # name = users._meta.get_field('name').verbose_name
        # self.assertEquals(name,'姓名')




    # VIEW
    def test_app_user_login_success(self):
        """APP用户登录接口成功情况"""

# path使用硬编码，不要使用reverse反解析url，以便在修改url之后能及时发现接口地址变化，并通知接口使用人员
        path = '/admin/login/'
        response = self.client.post(path, self.data,follow=True)
# response.data是字典对象
# response.content是json字符串对象
        self.assertEquals(response.status_code,
                    status.HTTP_200_OK,
                    '登录接口返回状态码错误: 错误信息: {}'.format(str(response.content,encoding='utf-8')))



class UserPermissonTestCase(TestCase):
    def setUp(self):
        self.user = User.objects.create(username="femn") # username也可以
        self.user.set_password("111111")
        self.user.save()
        self.client.force_login(self.user)

    def test_user_permisson(self):
        # header = {'Authorization':'Token 96f467972a8c25009b71b26d740f7f82b696763c'}
        path = '/api/v1/shopcarts/'
        response = self.client.get(path)
        self.assertEquals(response.status_code,
                    status.HTTP_200_OK,
                    '/api/v1/shopcarts/: 错误信息: {}'.format(str(response.content,encoding='utf-8')))

    def test_user_login_param(self):
        # header = {'Authorization':'Token 96f467972a8c25009b71b26d740f7f82b696763c'}
        path = 'auth/login/'
        response = self.client.post(path)
        print(response.content)
