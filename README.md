### 项目说明
是一个慕学生鲜商城项目,旨在学习和运用python,django,DRF,docker,docker-compose
- [简单认识django和DRF](mxshop/README.md)
- [django的第三方工具包的简单使用说明](mxshop/mxshop/README.md)
- [简单认识Dokcer](./Dockerfiles/README.md)
- 如果没有接触Docker的同学,可以使用[没有Docker版本的安装步骤](mxshop/no_docker_install.md)

### 项目启动
#### 1.1:启动ELK日志系统(如果不需要请忽略此步骤)
```bash
cd docker-elk
# 创建images,第一次时执行
docker-compose build
# 启动ELK日志系统
docker-compose up

```

[具体一点的操作说明](./docker-elk/README.md)

#### 1.2:启动之后,打开[Kibana日志系统后台](http://127.0.0.1:5601/),如果没有出现下图画面
![kibana创建index.png](https://i.loli.net/2020/06/16/6seiAZYUgrTRE7c.png)

则用代码创建:
```bash
# 为Kibana创建一个index pattern
# 有可能json格式不正确,导致上传失败,多换下-d的内容,试试
curl -XPOST -D- "http://localhost:5601/api/saved_objects/index-pattern" \
    -H "Content-Type: application/json" \
    -H "kbn-version: 6.1.0" \
    -d "{\"attributes\":{\"title\":\"logstash-*\",\"timeFieldName\":\"@timestamp\"}}"

    # -d '{"attributes":{"title":"logstash-*","timeFieldName":"@timestamp"}}


# 为了 docker-elk/logstash/pipeline/logstash.conf-->index => "nginx",而创建
curl -XPOST -D- "http://localhost:5601/api/saved_objects/index-pattern" \
    -H "Content-Type: application/json" \
    -H "kbn-version: 6.1.0" \
    -d "{\"attributes\":{\"title\":\"nginx*\",\"timeFieldName\":\"@timestamp\"}}"
```



#### 2.1:第一次启动项目所需要的配置步骤
```bash
cd ../Dockerfiles
docker-compose build  # 耐心等待下载images
# 启动项目
docker-compose up 
# 迁移数据库
docker exec -it dockerfiles_web_1 bash
# 如果没有数据库则会自动创建,所以之后记得改数据库的字符集
python3 manage.py makemigrations
python3 manage.py migrate
# 收集静态文件
python3 manage.py collectstatic(要执行)

# 创建管理员
python3 init_admin.py
# 还需要重置下密码
python3 manage.py changepassword admin (输入asdf1234)

# 更新数据
docker exec -it dockerfiles_mysql_1 bash
mysql -uroot -p123456 mxshop1 < /home/mxshop.sql
mysql -uroot -p123456
    # 改变数据库的字符集
    ALTER DATABASE mxshop1 CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
    # 改变表的字符集,在需要的表加就可以了,其它的表就不要动
    alter table mxshop1.goods_goods convert to character set utf8mb4 collate utf8mb4_bin;
# 可用GUI登陆mysql,redis
docker exec -it dockerfiles_redis_1 bash
redis-cli



```

#### 2.2: 之后启动项目
```bash
cd Dockerfiles
# 修改mxshop/mxshop/celery.py的HOST_IP值(要执行)
docker-compose up
```

#### 2.3: 想使用elk收集日志

```
# 先开启elk
# 再启动web部分项目
docker-compose up nginx     # 推荐
# 一起时


worker和vue容器,一启动,都会导致ES失败!!我嘞个去🥶🥶
已经将之前node名改成vue也是一样,所以不是命名问题
也不是先web,后elk的事,天啊

# 启动web的全项目,先关掉elk,等用完web之后,再启动elk来收集 😓😓

```




### 其它说明

| 名词 | 含义 | 
| :------: | :------: | 
| http://127.0.0.1/api/v1/ | [DRF总路由](http://127.0.0.1/api/v1/)   |
| http://127.0.0.1/admin/ | [DRF后台管理](http://127.0.0.1/admin/):admin,asdf1234   |
| http://127.0.0.1:3000/ |  [vue项目路由](http://127.0.0.1:3000)  |
| http://127.0.0.1:5601/ |  [Kibana日志系统后台](http://127.0.0.1:5601/)  |
| mysql数据库 | 用户名,密码:root,123456  |
| 在Pycharm上对项目的设置  | 将MxShop下的apps和extra_apps目录<br>设置成Sources Root  |
| 如果想在Pycharm将docker-compose作为远程解释器  | [参考这里进行设置](https://www.leipengkai.com/article/46/)  |



### 为什么不再使用pychram去启动docker-compose.yml
- 只能指定一个docker-compose.yml中的web服务,从而带动启动它的依赖服务
- 主要原因在于docker-compose up 和pychram启动docker-compose.yml不兼容
    - 一些连接服务的输入方式不一样,一些特殊的连接服务的方式,两者来回启动会互相影响
    - docker commit 之后,另一种启动方式将会失败
    - 不方便记忆,来回切换需要改的配置
#### 解决的办法:
- docker-compose up  启动所有服务,也就是整个项目
- docker-compose up mysql redis mq worker  # 启动web服务所依赖的服务
    - 使用pycharm启动web服务(python包,修改连接服务的连接写法(mysql,rdis,mq))
    - docker commit 只会针对docker-compose up这种启动方式.同时也很方便的添加python包
两种方法启动, 只需要改mxshop/__init__.py和setting.py文件
