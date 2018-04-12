from django.test import TestCase,client
from rest_framework.test import APITestCase
from rest_framework import status
from rest_framework.test import APIClient
from django.contrib.auth import get_user_model
from django.contrib.auth import login

from .models import UserProfile,VerifyCode

User = get_user_model()
#
# class TestcaseUserBackend(object):
#     def authenticate(self, testcase_user=None):
#         return testcase_user
#
#     def get_user(self, username):
#         return User.objects.get(username=username)



class UsersTestCase(TestCase):

    def setUp(self):

        self.data= {'name':'femn','password':'111111','email':'femn@gmail.com'}
        self.user = User.objects.create(**self.data)
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
        users = UserProfile.objects.get(name='femn')
        max_length = users._meta.get_field('name').max_length
        self.assertEquals(max_length,30)




    # VIEW
    def test_app_user_login_success(self):
        """APP用户登录接口成功情况"""

# path使用硬编码，不要使用reverse反解析url，以便在修改url之后能及时发现接口地址变化，并通知接口使用人员
        path = '/api-auth/login/'
        response = self.client.post(path, self.data,follow=True)
# response.data是字典对象
# response.content是json字符串对象
        self.assertEquals(response.status_code,
                    status.HTTP_200_OK,
                    '登录接口返回状态码错误: 错误信息: {}'.format(str(response.content,encoding='utf-8')))
        # auth = client.Client.login(password='111111',username='femn')
        # self.assertEquals(auth,True)
        # self.assertTrue(response.context['user'].is_authenticated)

        print(response)



class UserPermisson(TestCase):
    def setUp(self):
        self.user = User.objects.create(username="lolwutboi")
        self.user.set_password("whatisthepassword")
        self.user.save()
        self.client.force_login(self.user)

    def test_user_permisson(self):
        # header = {'Authorization':'Token 96f467972a8c25009b71b26d740f7f82b696763c'}
        path = '/shopcarts/'
        response = self.client.get(path)
        self.assertEquals(response.status_code,
                    status.HTTP_200_OK,
                    '登录接口返回状态码错误: 错误信息: {}'.format(str(response.content,encoding='utf-8')))
