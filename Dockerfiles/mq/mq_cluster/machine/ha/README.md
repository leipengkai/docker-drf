### 安装工具
```
cd machine

docker-machine create --driver virtualbox ha1
docker-machine ssh ha1 " tce-load -wi vim"

docker-machine ssh ha1 "sudo curl -L https://github.com/docker/compose/releases/download/1.18.0/docker-compose-Linux-x86_64 -o /usr/local/bin/docker-compose "
docker-machine ssh ha1 "sudo chmod +x /usr/local/bin/docker-compose"
docker-machine ssh ha1 "ps -ef |grep docker-compose"
docker-machine ssh ha1 "sudo kill -9 2860"
# ha1_ip:192.168.99.103
```

### 启动

```
ha/haproxy.cfg 改成vm2的ip

dm scp -r ha ha1:/home/docker/
dm scp -r ha/docker-compose.yml ha1:/home/docker/ha/docker-compose.yml
dm scp -r ha/haproxy.cfg ha1:/home/docker/ha/haproxy.cfg
docker-machine ssh ha1 "docker-compose --file ./ha/docker-compose.yml up" 
docker-machine ssh ha1 "docker-compose --file ./ha/docker-compose.yml down" 


```
### 发现不起作用, 然后使用下面的方式安装

```
docker-machine ssh ha1 "wget http://tinycorelinux.net/4.x/x86/tcz/haproxy.tcz"
docker-machine ssh ha1 "tce-load -i haproxy.tcz "
docker-machine ssh ha1 "haproxy --version"

docker-machine ssh ha1 " tce-load -wi haproxy"
# 安装失败
```




http://192.168.99.103:1936/ # haproxy监控页面
http://192.168.99.103:15672/ # mq_ui

keepalived 
ip a
docker exec -it ha_haproxy_1 bash

/usr/sbin/keepalived --dont-fork --dump-conf --log-console --log-detail --log-facility 7 --vrrp -f /keepalived/keepalived.conf



dm ssh vm3
docker exec -it ha_haproxy_1 bash



docker-machine scp ./docker-compose vm2:/usr/local/bin/

docker-machine ssh vm2 "sudo curl -L https://github.com/docker/compose/releases/download/1.18.0/docker-compose-Linux-x86_64 -o /usr/local/bin/docker-compose "

docker-machine ssh vm2 "sudo chmod +x /usr/local/bin/docker-compose"
docker-machine ssh vm2 "docker-compose --version"

docker-machine ssh vm2 "docker pull rabbitmq:3-management"
docker-machine ssh vm2 "pwd"  # /home/docker


docker-machine scp ./cluster-entrypoint.sh vm2:/home/docker/
docker-machine scp ./docker-compose.yml vm2:/home/docker/


docker-machine ssh vm2 "ls -al" 
docker-machine ssh vm2 "docker-compose up" 
docker-machine ssh vm2 "docker-compose down" 



alias dm=docker-machine
dm stop vm2 # 不能保存,目前只能通过virbox APP保存状态
dm start vm2



dm ssh vm2
docker exec -it rabbitmq-node-1 bash
rabbitmqctl add_user admin
rabbitmqctl list_users
rabbitmqctl set_user_tags admin administrator

### 

docker-machine create --driver virtualbox ha1
docker-machine ssh ha1 " wget http://tinycorelinux.net/4.x/x86/tcz/haproxy.tcz"
docker-machine ssh ha1 "tce-load -i haproxy.tcz"
docker-machine ssh ha1 "haproxy --version"

docker-machine create --driver virtualbox ha2

docker-machine scp ./docker-compose.yml vm2:/home/docker/
