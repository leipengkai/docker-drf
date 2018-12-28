### 项目说明
是一个商城项目,旨在学习和运用docker,docker-compose,django,DRF
- [简单认识django和drf](./MxShop/README.md)
- [django的工具使用简单说明](./MxShop/MxShop/README.md)
- [简单认识Dokcer](./Dockerfiles/README.md)
- 如果没有接触Docker的同学,可以使用[没有Docker版本的安装步骤](./MxShop/no_docker_install.md)

### 项目启动
#### 1:[启动ELK日志系统](./docker-elk/README.md)
```bash
cd docker-elk
# 创建images,第一次时执行
docker-compose build
# 启动ELK日志系统
docker-compose up
```

#### 2.1:第一次启动项目所需要的配置步骤
```bash
cd ../Dockerfiles
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
    # 改变数据库的字符集
    ALTER DATABASE mxshop1 CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
    # 改变表的字符集,在需要的表加就可以了,其它的表就不要动
    alter table mxshop1.goods_goods convert to character set utf8mb4 collate utf8mb4_bin;
# 可用GUI登陆mysql,redis
docker exec -it dockerfiles_redis_1 bash
redis-cli

# 访问
http://127.0.0.1/api/v1/
http://127.0.0.1/admin/

```

#### 2.2: 之后启动项目
```bash
cd Dockerfiles
docker-compose up
```