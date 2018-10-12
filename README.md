#### 启动ELK日志系统,[具体教程请参考这里](https://github.com/twtrubiks/docker-elk-tutorial)
```bash
cd docker-elk
# 创建images
docker-compose build
# 启动
docker-compose up
```

#### 启动项目
```bash
	cd Dockerfiles
	docker-compose build  # 耐心等待下载images
	docker-compose up 
    # 迁移数据库
	docker exec -it dockerfiles_web_1 bash
    python3 manage.py makemigrations
    python3 manage.py migrate
    # 收集静态文件
    python3 manage.py collectstatic

    # 创建管理员
    python3 init_admin.py
    # 还需要重置下密码
	python3 manage.py changepassword admin (输入asdf1234)

	# 更新数据
	docker exec -it dockerfiles_mysql_1 bash
    mysql -uroot -p123456 mxshop1 < /home/mxshop.sql
	mysql -uroot -p123456
        alter database mxshop1 default character set utf8;

	# 可用GUI登陆mysql,redis
	docker exec -it dockerfiles_redis_1 bash
	redis-cli

    # 访问
    http://127.0.0.1/api/v1/
    http://127.0.0.1/admin/

```
### [Django](https://docs.djangoproject.com/zh-hans/2.0/):Python web框架

- 大而全的功能组件
- 高效开发
- 全自动化的管理后台
- MVT架构 M-model数据模型 V-view视图 T-template模板
- 高效的ORM数据操作,完善的路由地址映射,强大的视图模板支持
- 多线程多用户高效服务
部署时采用wsgi协议与服务器对接(被服务器托管),而这类服务器通常都是基于多线程的,也就是说每一个网络请求服务器都会有一个对应的线程来用web应用(如Django)进行处理.


### [Django-rest-framework](http://www.django-rest-framework.org/):是一个开源的Django扩展,提供了便捷的REST API开发框架

- 直观的API web界面,以及提供开发文档
- 多种身份认证和权限认证方式的支持
- 内置了限流系统
- 内置了 OAuth1 和 OAuth2 的支持
- 根据 Django ORM 或者其它库自动序列化
- 丰富的定制层级:函数视图,类视图,视图集合到自动生成 API,满足各种需要.
- 可扩展性,插件丰富,广泛使用,文档丰富

######  [理解RESTful架构](http://www.ruanyifeng.com/blog/2011/09/restful)和[RESTful API 设计指南](http://www.ruanyifeng.com/blog/2014/05/restful_api.html)
- RESTful API只是一个(设计API)标准不是个框架,是前后端分离最佳实践
- API(面向资源(一个实体或者是一个网络上的具体信息或url):名词复数) + http协议(put/get/post/delete动词(状态转化 ))
- 客户端和服务器之间,传递这种资源的某种表现层
- URL/版本信息/名词复数

###### [Serializer-Mixins-ViewSets](http://www.cdrf.co/)
- [ViewSet](https://blog.csdn.net/l_vip/article/details/79131289):router的动态绑定HTTP操作以及action操作(获取相应的Serializer),自定义返回给前端的内容以及状态

- [Minxins](https://blog.csdn.net/l_vip/article/details/79142105):按Mixin的权限去操作Serializer对象(perform_create,perform_update,list...),数据保存(更新)后的逻辑后续处理

- [Serializer](https://blog.csdn.net/l_vip/article/details/79156113):序列化与反序列Serializer对象(验证并保存更新(create,update...)以及展示(fileds)Serializer对象)在数据保存之前进行相关操作

- [xadmin使用](http://wongbingming.me/2018/1/16/Django-Xdamin.html)

- [JWT官方文档](https://github.com/GetBlimp/django-rest-framework-jwt),[JWT认证](https://blog.leapoahead.com/2015/09/07/user-authentication-with-jwt/):用户信息保存在客户端,服务端只需要加解密和解编码就可以获取用户信息

##### [view的关系图](./all_views.png)

##### DRF大概流程
Request-> Router: 认证

Router->ViewSet:路由匹配并得到对应的序列化

ViewSet->Authentication: 身份校验

Authentication->Throutting: 限流

Throutting->Mixins: 对应序列化权限

Mixins->Serializer->:序列化请求

if 反序列化:

Serializer->Filter: 根据定义的 Filter 验证 Query

if 序列化:

Serializer->Field: 根据定义的 Field 序列化 Serializer 查询结果

Serializer->Responce: 返回结果和状态

Responce->Renderer: 根据请求头寻找最合适的 Renderer 渲染响应结果

### 编写docker-compose.yml遇到的坑
mysql,redis启动之后,web一直连接不上,没有一点头绪的我,最后是google :docker-compose.yml django can't connect to mysql.(之前也不知道是怎么google的)

才找到[解决的办法](https://stackoverflow.com/questions/47979270/django-cannot-connect-mysql-in-docker-compose),原来是在setting.py中配置数据库时,HOST必须是指定service的名字,而不是0.0.0.0或者其它任何一个这种形式的HOST

### 更新到目前最新的Django和Jet后,在admin在遇到的bug

    # 进入容器
    docker exec -it dockerfiles_web_1 bash

- render() got an unexpected keyword argument 'renderer'
        apt install vim
        vim /usr/local/lib/python3.6/site-packages/django/forms/boundfield.py
        将93L的代码注释掉

- __init__() missing 1 required positional argument: 'sortable_by'
        vim /usr/local/lib/python3.6/site-packages/jet/utils.py 
        223L 加上 model_admin.sortable_by
        exit


    docker ps |grep dockerfiles_web
    # 将容器commit成image
    docker commit -m " jet bug" 3e292079cf43  dockerfiles_web:latest

##### [持续集成](http://www.ruanyifeng.com/blog/2015/09/continuous-integration.html)
CI(continuous intergation)持续集成指的是,频繁地(一天多次)将代码集成到主干,让产品可以快速迭代,同时还能保持高质量.它的核心措施是,代码集成到主干之前,必须通过自动化测试.只要有一个测试用例失败,就不能集成.持续集成并不能消除Bug,而是让它们非常容易发现和改正.
持续集成强调开发人员提交了新代码之后,立刻进行构建,(单元)测试.根据测试结果,我们可以确定新代码和原有代码能否正确地集成在一起.

持续交付(Continuous delivery)指的是,频繁地将软件的新版本,交付给质量团队或者用户,以供评审.如果评审通过,代码就进入生产阶段.
持续交付可以看作持续集成的下一步.它强调的是,不管怎么更新,软件是随时随地可以交付的.

持续部署(continuous deployment)是持续交付的下一步,指的是代码通过评审以后,自动化部署到生产环境.
持续部署的目标是,代码在任何时刻都是可部署的,可以进入生产阶段.

后者再前者的基础之上进一步自动化.

持续部署的前提是能自动化完成测试,构建,部署等步骤.
所谓构建,指的是将源码转换为可以运行的实际代码,比如安装依赖,配置各种资源(样式表,JS脚本,图片)等等



https://www.jianshu.com/p/40eefc5d6ff8
Jenkins的主要目标是监控软件开发流程,快速显示问题.所以能保证开发人员以及相关人员省时省力提高开发效率.
CI系统在整个开发过程中的主要作用是控制:当系统在代码存储库中探测到修改时,它将运行构建的任务委托给构建过程本身.如果构建失败了,那么CI系统将通知相关人员,然后继续监视存储库.它的角色看起来是被动的;但它确能快速反映问题.

部署一个CI系统需要的最低要求是,一个可获取的源代码的仓库,一个包含构建脚本的项目.

Jenkins 是一个可扩展的持续集成引擎(java).
主要用于:

构建可持续的自动化检查:新增或修改后的代码时,CI系统会不断确认这些新代码是否破坏了原有软件的成功构建.
构建可持续的自动化测试:构建检查的扩展部分,构建后执行预先制定的一套测试规则,完成后触发通知(Email,RSS等等)给相关的当事人
软件构建自动化:配置完成后,对目标软件进行构建,部署.

