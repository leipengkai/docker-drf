### 简单使用
```bash
	cd Dockerfiles
	docker-compose build  # 耐心等待下载images
	docker-compose up 
	# 可用GUI登陆mysql,redis

	# 命令行登陆,则需要进入容器中
	docker exec -it dockerfiles_mysql_1 bash
	mysql -uroot -p123456
	docker exec -it dockerfiles_redis_1 bash
	redis-cli

	# 登陆后台的话,还需要重置下密码
	docker exec -it dockerfiles_web_1 bash
	python3 manage.py changepassword admin (输入asdf1234)

```



### [Django](https:docs.djangoproject.com/zh-hans/2.0/):Python web框架

- 大而全的功能组件
- 高效开发
- 全自动化的管理后台
- MVT架构 M-model数据模型 V-view视图 T-template模板
- 高效的ORM数据操作,完善的路由地址映射,强大的视图模板支持
- 多线程多用户高效服务
部署时采用wsgi协议与服务器对接(被服务器托管),而这类服务器通常都是基于多线程的,也就是说每一个网络请求服务器都会有一个对应的线程来用web应用(如Django)进行处理.


### [Django-rest-framework](http:www.django-rest-framework.org/):是一个开源的Django扩展,提供了便捷的REST API开发框架

- 直观的API web界面,以及提供开发文档
- 多种身份认证和权限认证方式的支持
- 内置了限流系统
- 内置了 OAuth1 和 OAuth2 的支持
- 根据 Django ORM 或者其它库自动序列化
- 丰富的定制层级:函数视图,类视图,视图集合到自动生成 API,满足各种需要.
- 可扩展性,插件丰富,广泛使用,文档丰富

######  [理解RESTful架构](http:www.ruanyifeng.com/blog/2011/09/restful)和[RESTful API 设计指南](http:www.ruanyifeng.com/blog/2014/05/restful_api.html)
- RESTful API只是一个(设计API)标准不是个框架,是前后端分离最佳实践
- API(面向资源(一个实体或者是一个网络上的具体信息或url):名词复数) + http协议(put/get/post/delete动词(状态转化 ))
- 客户端和服务器之间，传递这种资源的某种表现层
- URL/版本信息/名词复数

###### [Serializer-Mixins-ViewSets](http:www.cdrf.co/)
- [Serializer](https:blog.csdn.net/l_vip/article/details/79156113):序列化数据(验证并保存以及展示)在数据保存之前进行相关操作

- [Minxins](https:blog.csdn.net/l_vip/article/details/79142105):获取相应的Serializer,并调用Serializer的相应操作

- [ViewSet](https:blog.csdn.net/l_vip/article/details/79131289):router的动态绑定HTTP操作以及action操作,自定义返回给前端的内容以及状态

- [xadmin使用](http:wongbingming.me/2018/1/16/Django-Xdamin.html)

- [JWT官方文档](https:github.com/GetBlimp/django-rest-framework-jwt),[JWT认证](https:blog.leapoahead.com/2015/09/07/user-authentication-with-jwt/):用户信息保存在客户端,服务端只需要加解密和解编码就可以获取用户信息

### 编写docker-compose.yml遇到的坑
mysql,redis启动之后,web一直连接不上,没有一点头绪的我,最后是google :docker-compose.yml django can't connect to mysql.(之前也不知道是怎么google的)

才找到[解决的办法](https:stackoverflow.com/questions/47979270/django-cannot-connect-mysql-in-docker-compose),原来是在setting.py中配置数据库时,HOST必须是指定service的名字,而不是0.0.0.0或者其它任何一个这种形式的HOST
