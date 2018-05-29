### 为什么使用docker
1.快速创建环境(开发,测试,生产),并保证环境的一致性

2.整体交付(运行环境+代码(之前只是代码)):

3.更好的完成DevOps(解决Develop(开发)和Operation(运维)的代沟)

### docker基本概念
##### imagei(镜像):可以理解为安装在虚拟机上的操作系统(容量小,启动快,数量多),只读层
通常是由Dockerfile来生成,推荐一个镜像里只运行一个服务
```bash
docker build -t nginx . # 由当前目录下的Dockerfile文件生成一个名字为nginx的镜像
# images命令
```
##### Container(容器):理解为操作系统上的进程 ,imgae + 读写层
利用镜像创建出来的,一个镜像可以创建出多个不同的容器,并且是互相分离的.
如nginx镜像,通过镜像启动一个nginx容器,其实就是在主机上启动了一个nginx进程

```bash
docker run -it --rm -p 80:80 --name test_nginx nginx
# 根据nginx镜像生成一个 test_nginx容器
docker run -it --rm -p 81:80 --name test_nginx2 nginx
# Container命令
```
##### Volume(数据巻):持久化容器数据(volumes),以及容器之间共享数据(volumes_from)
将在容器中产生的数据保留起来,默认是保存在主机的/var/lib/docker/volumes目录下


##### docker-compose:管理容器的工具(定义,执行,关联多个容器)

docker-compose.yml文件来定义,它会自动设置网络模式,来解决容器之间的通信(links)
```bash
# 就相当于在跑容器时,指定了容器的参数

docker network create my_network # 创建一个网络
docker run --name mysql -v ./database/mysql:/var/lib/mysql -p 3306:3306 \
	--network=my_network -e POSTGRES_PASSWORD=123456 mysql:5.7

docker run --name web -v ..MxShop/code -p 8000:8000 --network=my_network \
	--restart always web_image python manage.py runserver 0.0.0.0:8000

```

同时docker-compose定义的容器单独拿来使用或者被使用其它容器使用
```bash
docker run -d --name mysql2 -p 3307:3306 -e MYSQL_ROOT_PASSWORD=123456  mysql:5.7

docker run -d --name mysql3 -p 3308:3306 --volumes-from mysql mysql:5.7
```

##### 本例docker编写的思路
1.尽量不改变原来项目的结构,在同级目录下创建一个新目录

2.使用docker-compose.yml来管理,编排容器

3.建立mysql,redis,web这三个必须的容器,并设置容器相关属性

##### 启动容器
```bash
cd Dockerfiles
docker-compose up
# 如果启动有错误的话,可以用下面的命令来清除下缓存,再重新启动
docker-compose ps
docker-compose rm
```

###### 进入mysql容器,第一次启动时,需要设置uft8字符集
```bash
# 在docker-compose.yml不知道怎样设置
docker exec -it dockerfiles_mysql_1 bash

# 进入mysql
$ mysql -uroot -p123456
# 设置uft8字符集
mysql> alter database mxshop1 default character set utf8;

```

###### 进入web容器,初始化数据库
```bash
docker exec -it dockerfiles_web_1 bash

$ python3 manage.py makemigrations
$ python3 manage.py migrate

# 创建管理员
$ python3 init_admin.py

# 如果不能登陆,则改下密码
$ python3 manage.py changepassword admin

# 收集静态文件
$ python3 manage.py collectstatic
```

