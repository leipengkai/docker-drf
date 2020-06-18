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




### 外网打不开时
- 查看ports的容器启动expose是不是正确
- 是否正常映射到http://localhost:9000/,显示xx:xx
- 查看容器的日志

### 启动agent
```bash
docker-compose up

# 得到 IPAddress
docker inspect zabbix-agent

# Zabbix后台
打开Zabbix后台-->Monitoring-->Hosts-->Zabbix server-->Configuration-->IP address-->填入刚刚得到的IP-->update

# CLI,更新config
docker exec -it zabbix-server zabbix_server -R config_cache_reload

# Zabbix后台
点击Apply

# 重启
docker-compose restart
```
<center>![zabbix-agent.gif](https://i.loli.net/2020/06/18/RuIXpbhUoKzF216.gif)</center>


### bug
```bash
Zabbix server


zabbix-agent            |   1692:20200618:092235.633 no active checks on server [zabbix-server:10051]: host [zabbix-server] not found
zabbix-server           |    202:20200618:092235.633 cannot send list of active checks to "172.16.239.6": host [zabbix-server] not found



Get value from agent failed: cannot connect to [[127.0.0.1]:10050]: [111] Connection refused

docker exec -it zabbix-docker_zabbix-agent_1 bash
ps -ef |grep zabbix-agent
    2932 zabbix    0:00 grep zabb
netstat -tlnp |grep 10050



docker exec -it zabbix-docker_mysql-server_1 bash

docker exec -it zabbix-docker_zabbix-web-nginx-mysql_1 bash
    bash-5.0$ ps -ef |grep 8080
       66 zabbix    0:00 grep 8080
    bash-5.0$ ps -ef |grep 8443
       68 zabbix    0:00 grep 8443
    bash-5.0$


https://blog.51cto.com/13589448/2068034
                                                          
failed to accept an incoming connection: connection from "172.16.238.1" rejected, allowed hosts: "zabbix-agent"
     host [zabbix-server] not found
docker cp zabbix-agent:/etc/zabbix/zabbix_agentd.conf  ~/Downloads/
docker cp zabbix-agent:/etc/modprobe.d  ~/Downloads/
docker cp zabbix-agent:/etc/resolv.conf  ~/Downloads/
```



### 官方[github docker-compose](https://github.com/zabbix/zabbix-docker/blob/5.0/docker-compose_v3_alpine_mysql_latest.yaml)
```bash
# 下载好整个项目,并启动
docker-compose -f docker-compose_v3_alpine_mysql_latest.yaml up

# 也有很多坑,自己填吧
```

### 说明
| 参数 | 说明 |
| :------: | :------: | 
| [zibbix后台](http://0.0.0.0:8081/) | 默认用户名和密码Admin,zabbix  |
| mysql | 3309:3306,zabbix,zabbix,zabbix(name,pw,db) | 

