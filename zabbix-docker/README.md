### [Zabbix](https://www.zabbix.com/container_images)
[使用文档](https://www.zabbix.com/documentation/current/manual/installation/containers)

### 启动
```bash
cd zabbix-docker
docker-compose up

# 但会出现 cannot use database "zabbix": its "users" table is empty (is this the Zabbix proxy database?)
# 启动zabbix-server, 找到zabbix最初需要的数据
docker-compose up zabbix-server
docker exec -it zabbix-docker_zabbix-server_1 bash
    find / -name *sql
    exit
# 注意不要挂载出来,我试下,会覆盖掉容器本来就有的
docker cp zabbix-docker_zabbix-server_1:/usr/share/doc/zabbix-server-mysql/create.sql.gz  ~/Downloads/

# 启动Mysql
docker-compose up mysql-server
解压:create.sql.gz,并导入数据库中

# create.sql.gz已经保存到此项目中
```

### 可能用到的命令
```bash

# 得到容器的内部ip
docker inspect $(docker ps -f "name=zabbix-web-nginx" --format "{{.ID}}") --format='{{ (index .NetworkSettings.Networks "zabbix-docker_zbx_net_frontend").IPAddress  }}'

# 进入容器
docker exec -it zabbix-docker_zabbix-web-nginx-mysql_1 bash 

```



### 找到create user sql



### 官方[github docker-compose](https://github.com/zabbix/zabbix-docker/blob/5.0/docker-compose_v3_alpine_mysql_latest.yaml)
```bash
# 下载好整个项目,并启动
docker-compose -f docker-compose_v3_alpine_mysql_latest.yaml up
```

### 说明
| 参数 | 说明 |
| :------: | :------: | 
| [zibbix后台](http://0.0.0.0:8081/) | 默认用户名和密码Admin,zabbix  |
| mysql | 3309:3306,zabbix,zabbix,zabbix(name,pw,db) | 

