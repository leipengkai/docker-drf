### 说明
- 下载好此项目之后,就不需要理会docker-elk和Dockerfiles这两个目录了

### 安装运行环境(如使用docker则不需要)
python版本(ubuntu16.04版本)
```bash
sudo add-apt-repository ppa:deadsnakes/ppa
sudo apt-get update
sudo apt-get install python3.6
sudo rm /use/bin/python3
ln -s /usr/bin/python3.6 /usr/bin/python3

pip3 list
# 如果有问题执行:
export LC_ALL=C
```
依赖包下载与配置
```bash
sudo apt-get install libmysqlclient-dev  python3.6-dev mysql-server redis-server redis-tools
# 如果是二进制下载的,设置开机启动
/etc/init.d/redis-server start
systemctl enable redis.service
vim /etc/redis/redis.conf
# bind 127.0.0.1


/etc/init.d/mysql start
systemctl enable mysql.service
# 配置文件一般是在/etc/my.conf
vim /etc/mysql/mysql.conf.d/mysqld.cnf
bind-address		 = 0.0.0.0

```

安装python包的问题:
```bash
(sudo)pip3 install -U -r  requirements.txt
(sudo)pip3 install xadmin

# 如果xadmin有问题的话,则需要对应django版本
# 当 xadmin --> admin,想要兼容两个管理系统的话,django版本为:1,则
pip3 install xadmin
# 如果版本为>=2,则将pip3 install xadmin换成
proxychains4 pip3 install git+git:github.com/sshwsfc/xadmin.git@django2

# 同时django2的版本还需要解决:list index out of range错误,将 xadmin/widgets.py 75的代码改成:
input_html = [ht for ht in super(AdminSplitDateTime, self).render(name, value, attrs).split('>') if ht != '']
```

安装vue依赖包和运行vue
```bash
# 安装nodejs npm
sudo apt-get install -y nodejs npm

# 安装和更新node
sudo npm install -g n
sudo n stable  # 稳定版本  sudo n latest最新版本
n ls  # 查看Node所有版本

# 更新npm(Node.js包管理工具):
sudo npm install npm@latest -g

# 普通用户也用最新版本：
sudo chown -R $USER:$(id -gn $USER) /home/femn/.config

# 使用淘宝镜像安装第三方包:
cd
sudo npm install -g cnpm --registry=https:registry.npm.taobao.org
cnpm --version

# 安装vue依赖包和运行vue
unzip online-store.zip
cd online-store
cnpm install
cnpm run dev
```

数据库方面的设置
```bash
CREATE DATABASE `mxshop1` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
GRANT ALL PRIVILEGES ON mxshop1.* TO 'root'@'%' IDENTIFIED BY '123456';
FLUSH PRIVILEGES;

# 当APP中没有 migrations文件时参考下面的两个命令 生成migrations文件
    python3 manage.py makemigrations
    # 注意如果没有生成迁移文件则需要指定APP_name:
    python3 manage.py makemigrations users goods user_operation trade
    # 当修改Model之后,python3 manage.py makemigrations就可以创建所有的APP_migrations文件
python3 manage.py migrate
cd db_tools
mysql -uroot -p123456 mxshop1 < mxshop.sql
cd ..
python3 manage.py runserver
# username:admin password:asdf1234

# 如果自动创建一个新管理帐号的话：
python3 manage.py createsuperuser
# 则可能需要 再改下密码 才能登陆成功
python3 manage.py changepassword

```
