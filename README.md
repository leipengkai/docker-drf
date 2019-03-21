### 项目说明
是一个慕学生鲜商城项目,旨在学习和运用python,django,DRF,docker,docker-compose
- [简单认识django和DRF](./MxShop)
- [django的第三方工具包的简单使用说明](./MxShop/MxShop)
- [简单认识Dokcer](./Dockerfiles)
- 如果没有接触Docker的同学,可以使用[没有Docker版本的安装步骤](./MxShop/no_docker_install.md)

### 项目启动
#### 1:启动ELK日志系统(如果不需要请忽略此步骤)
```bash
cd docker-elk
# 创建images,第一次时执行
docker-compose build
# 启动ELK日志系统
docker-compose up

# 为Kibana创建一个index pattern
curl -XPOST -D- "http://localhost:5601/api/saved_objects/index-pattern" \
    -H "Content-Type: application/json" \
    -H "kbn-version: 6.1.0" \
    -d '{"attributes":{"title":"logstash-*","timeFieldName":"@timestamp"}}’
```
[具体一点的操作说明](./docker-elk/)

#### 2.1:第一次启动项目所需要的配置步骤
```bash
cd ../Dockerfiles
docker-compose build  # 耐心等待下载images
docker-compose up 
# 迁移数据库
docker exec -it dockerfiles_web_1 bash
# 如果没有数据库则会自动创建,所以之后记得改数据库的字符集
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
docker-compose up
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
| 如果想在Pycharm将docker-compose作为远程解释器  | [参考这里进行设置](https://www.leipengkai.com/article/46)  |
