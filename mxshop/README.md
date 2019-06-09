### [Django](https://docs.djangoproject.com/zh-hans/2.0/):Python web框架

- 大而全的功能组件
- 高效开发
- 全自动化的管理后台
- MVT架构 M-model数据模型 V-view视图 T-template模板
- 高效的ORM数据操作,完善的路由地址映射,强大的视图模板支持
- 多线程多用户高效服务
部署时采用wsgi协议与服务器对接(被服务器托管),而这类服务器通常都是基于多线程的,也就是说每一个网络请求服务器都会有一个对应的线程来用web应用(如Django)进行处理.

### Django处理流程
```bash
python manage.py runserver 0.0.0.0:80 
# ruserver是使用django自己的web server,主要用于开发和调试中,部署到线上环境一般使用nginx+uwsgi模式
```

本项目是:

- the web client <-> 
- the web server(Nginx,http,应用层)<->
- unix socket(socket,传输层(http包通过socket方式解包/打包成TCP/UDP包)) <-> 
- uWSGI(用于描述web server如何与web application通信的规范) <->
- Django

#### 简单说明
- 加载settings.py并创建WSGIServer对象(启动django应用服务)
    - manage.py是将settings.py以及读取命令行的参数,而根据ip:port生成WSGIServer对象,接受用户请求,为每个请求的用户生成一个WSGIHandler
    - 与tornado差不多只不过它启动的是tornado.ioloop.IOLoop对象,单线程循环监听
- 通过中间件在Web服务器端和Web应用之间的添加额外功能
    - 对来自用户的数据进行预处理并生成Request对象,然后发送给应用
    - 中间件类至少含有以下四个方法中的一个: process_request,process_view,process_exception,process_response
    - WSGIHandler通过load_middleware将这个些方法分别添加到_request_middleware,_view_middleware,_response_middleware 和 _exception_middleware四个列表中. 其中request与view是按照顺序去执行的，而response和exception是反序的
- 处理Request
    - 通过Request对象获取到各类用户请求参数
- 返回Response

#### 具体说明
![django处理流程](https://ws1.sinaimg.cn/large/006tNbRwgy1fyooltssrcj30xj0kvgre.jpg)

### Nginx在本项目中的作用
- Nginx 比起 uWSGI 能更好地处理静态资源
- Nginx 可以设定 Cache 机制
- Nginx 可以设定 反向代理器
- Nginx 可以更方便配置ssl
- Nginx 可以进行多台机器的负载均衡( Load balance )

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

##### view的关系图
![view的关系图](https://ws2.sinaimg.cn/large/006tNbRwgy1fylripg5coj31pb0u0e81.jpg)
结合[url.py的93行](mxshop/urls.py)和[goods.views.py的151行](./apps/goods/views.py)有助于理解上面的图


###### [Serializer-Mixins-ViewSets](http://www.cdrf.co/)
- [ViewSet](https://blog.csdn.net/l_vip/article/details/79131289):router的动态绑定HTTP操作以及action操作(获取相应的Serializer),自定义返回给前端的内容以及状态

- [Minxins](https://blog.csdn.net/l_vip/article/details/79142105):选择提供增删改查逻辑中的多种或者一种操作权限
    - HTTP请求操作后,要有与之对应操作权限的Mixins(处理方法中具体的操作:create,delete,update,list,retrieve))
    - 然后Mixin再去操作对应的Serializer对象(perform_create,perform_update,list...),数据保存(更新)后的逻辑后续处理

- [Serializer](https://blog.csdn.net/l_vip/article/details/79156113):验证,展示,保存以及序列化与反序列化数据
    - 将用户请求来的数据格式反序列化成Seriaizer对象,对其验证字段并创建保存更新(create,update...)以及展示(fileds)Serializer对象
    - 最终通过instance.save()来保存和展示数据
    - 然后通过序列化Serializer对象转化成其它格式(JSON),返回给用户.在数据保存之前进行相关操作

- [xadmin使用](http://wongbingming.me/2018/1/16/Django-Xdamin.html)

- [JWT官方文档](https://github.com/GetBlimp/django-rest-framework-jwt),[JWT认证](https://blog.leapoahead.com/2015/09/07/user-authentication-with-jwt/):用户信息保存在客户端,服务端只需要加解密和解编码就可以获取用户信息

- [SKU模型简单设计](https://www.leipengkai.com/article/56/),包括model之间的关联,Serializer的便利性,熟悉ndm模型(明了模型之间的关系),复合主键,联合主键(多对多自定义关联)



##### DRF大概流程
Request-> Router: 认证

Router->ViewSet:路由匹配并得到对应的序列化

ViewSet->Authentication: 身份校验

Authentication->Throutting: 限流

Throutting->Mixins: 对应序列化操作权限

Mixins->Serializer->:序列化请求

if 反序列化:# 将post与patch/put的上来的数据进行验证

Serializer->Filter: 根据定义的 Filter 验证 Query

if 序列化:# queryset与model实例等进行序列化，转化成json格式，返回给用户(api接口)

Serializer->Field: 根据定义的 Field 序列化 Serializer 查询结果

Serializer->Responce: 返回结果和状态

Responce->Renderer: 根据请求头寻找最合适的 Renderer 渲染响应结果


### 更新到目前最新的Django和Jet后,在admin在遇到的bug
```bash
# 进入容器
docker exec -it dockerfiles_web_1 bash
# bug1:
- render() got an unexpected keyword argument 'renderer'
# 解决方法:
    apt install vim
    vim /usr/local/lib/python3.6/site-packages/django/forms/boundfield.py
    将93L的代码注释掉

# bug2 ,最新版本已经不存在这个bug了
- __init__() missing 1 required positional argument: 'sortable_by'
# 解决方法:
    vim /usr/local/lib/python3.6/site-packages/jet/utils.py 
    223L 加上 model_admin.sortable_by
# 退出容器
exit
docker ps |grep dockerfiles_web
# 将容器commit成image
docker commit -m " jet bug" 3e292079cf43  dockerfiles_web:latest
```


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

