
#### 简单使用
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

#### 遇到的坑

mysql,redis启动之后,web一直连接不上,没有一点头绪的我,最后是google :docker-compose.yml django can't connect to mysql.(之前也不知道是怎么google的)

才找到[解决的办法](https:stackoverflow.com/questions/47979270/django-cannot-connect-mysql-in-docker-compose),原来是在setting.py中配置数据库时,HOST必须是指定service的名字,而不是0.0.0.0或者其它任何一个这种形式的HOST

之前是改docker-compose.yml的配置(HOST),重新下载以及更换mysql镜像,甚至自定义创建mysql镜像(bind-address:下载是大概率事件是超慢地),通过GUI增加用户,配置远程登陆权限,之后就改项目的权限(777),无数次的重新下载web镜像
