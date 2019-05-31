### 第三方工具的使用
性能分析工具:
```bash
# 单个方法的性能分析
sudo apt-get install kcachegrind  # 运行kcachegrind  分析可视化工具
pip3 install pyprof2calltree  # 在worken mxshop 下载依赖包
pyprof2calltree -i mkm_run.prof -k

# Django中对文件的性能分析
pip3 install pyinstrument
# MIDDLEWARE = [
# 'pyinstrument.middleware.ProfilerMiddleware',
# ]
# PYINSTRUMENT_PROFILE_DIR = 'profiles'

# 当在url后面增加?profiles后,就会在项目的profiles的目录下生成一个对应的.html分析文件
0.0.0.0:8000/?profiles


# 对Django项目的性能分析
pip3 install django-extensions  debug_toolbar  # debug_toolbar用来DB查询语句及耗时时间
# INSTALLED_APPS = (
# 'django_extensions',
# 'debug_toolbar',
# )

mkdir ./apps/utils/profile_data
python3 manage.py runprofileserver --use-cprofile --prof-path=./apps/utils/profile_data

# 之后的对应的请求都会有一个.prof的文件生成
pyprof2calltree -i xx.prof -k
```


##### [TestCase单元测试](https://developer.mozilla.org/en-US/docs/Learn/Server-side/Django/Testing)
测试一个网站是一项复杂的工作，因为它由多层逻辑组成 - 从HTTP级别的请求处理，查询模型到表单验证和处理以及模板呈现.
我们应该测试任何属于我们设计的部分或由我们编写的代码定义的东西，但不测试已经由Django或Python开发团队测试过的库/代码.


unittest将在当前工作目录下任何使用模式test * .py命名的文件都会的测试,直接在pycharm中运行
大多数测试的最佳基类是django.test.TestCase(基于unittest)。此测试类在运行测试之前创建一个干净的数据库，并在其自己的事务中运行每个测试函数。
该类还拥有一个测试客户端，您可以使用该测试客户端模拟用户在视图级别与代码进行交互.

Django运行单元测试时，会以settings里的数据库配置里的NAME新建一个以test_开关的临时数据库，并在测试结束后删除,所以不用关心testDown()清理工作。
默认的测试数据库会以当前的migrations文件来创建数据表并进行迁移，但如果migrations文件很多，每次运行时间将很久，所以可以跳过迁移，直接以当前Model结果来创建表以提升测试效率.当您开始测试运行时，框架在您的派生类中执行选定的测试方法.
```bash
# from unittest import TestCase
# unittest模块:将在当前工作目录下任何使用模式test*.py命名的文件都会的测试(django.test也是一样)
# 通过Pycharm自动生成unittest测试:
open any file | right mouse |Go To |Test |Create New Test | select test method 
(只能对方法进行测试,然后直接在Pycharm运行就OK)
点击文件或目录,右击"Run py.test in tests"


# from django.test import TestCase(可对Model进行测试)
vim apps/goods/tests.py
# 通过Pycharm自动对test*.py文件进行测试:
select dir | rigth mouse |Profile 'Test xxdir'
# 但一直有错误RuntimeError:Model class xx doesn't declare an explicit app_label and isn't in an application in INSTALLED_APPS.
solve : Edit configurations |Custom settins --> project_path/settings.py  || Options-->--keepdb
同时导入 from goods.models import Goods, GoodsCategory   ,不用.models

# 也可以使用使用命令(相当于是指定Target)
python3 manage.py test --keepdb  users.tests  # 执行user项目下的tests包(test*.py文件)或者tests.py(文件)
python3 manage.py test --keepdb  users.tests.UsersTestCase # 单独执行某个test case
python3 manage.py test --keepdb  users.tests.UsersTestCase.test_app_user_login_success # 单独执行某个测试方法
python3 manage.py test --keepdb --settings=mxshop.settings tests

```
[pytest](https://pytest-django.readthedocs.io/en/latest/)
```bash
# Pycharm 默认是unittest，所以需要改下
Please go to File | Settings | Tools | Python Integrated Tools and change the default test runner to py.test

pip install pytest
py.test --version
```

[微博开放平台](http://open.weibo.com/) 认证一些基本信息就可以了
```bash
我的应用 | 应用信息 |高级信息|授权回调页| http://0.0.0.0:8008/complete/weibo/|其它的填空
再设置下 APP_KEY SECRET 
```
[第三方登陆](http://python-social-auth.readthedocs.io/en/latest/configuration/django.html)
```bash
# gitlab:social-app-django
pip3 install social-auth-app-django
访问: http://0.0.0.0:8008/index/weibo/
```
