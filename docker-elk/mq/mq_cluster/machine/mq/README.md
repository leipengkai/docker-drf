
http://tinycorelinux.net/8.x/x86/tcz/ : 包
https://distro.ibiblio.org/tinycorelinux/9.x/x86/tcz/

有个Linux发行版很小, 才15M: Tiny Core Linux ,没有apt-get yum,一直在弄这个,结果它有它的安装方式:
tce-load -wi vim

docker-machine ls
docker-machine rm vm3
### mq集群
docker-machine create --driver virtualbox vm2
docker-machine ssh vm2 " tce-load -wi vim"
docker-machine ssh vm2 " tce-load -wi service"
docker-machine ssh vm2 "  vim --version"
# /usr/local/share/vim

 docker-machine ssh vm2 " tce-load -wi nginx"

docker-machine ssh vm2 "nginx -v"
docker-machine ssh vm2 "nginx -t"

docker-machine ssh vm2 " wget http://tinycorelinux.net/8.x/x86/tcz/haproxy.tcz"
docker-machine ssh vm2 "tce-load -i haproxy.tcz /usr/local/sbin/"
docker-machine ssh vm2 "haproxy --version"  
失败: bash: /usr/local/sbin/haproxy: No such file or directory
/usr/local/sbin

docker-machine ssh vm2 "tce-load -w -i haproxy.tcz"

docker-machine ssh vm2 "sudo curl -L https://github.com/docker/compose/releases/download/1.18.0/docker-compose-Linux-x86_64 -o /usr/local/bin/docker-compose "

docker-machine ssh vm2 "sudo chmod +x /usr/local/bin/docker-compose"
docker-machine ssh vm2 "docker-compose --version"

docker-machine ssh vm2 "docker pull rabbitmq:3-management"
docker-machine ssh vm2 "pwd"  # /home/docker


docker-machine scp mq/cluster-entrypoint.sh vm2:/home/docker/
docker-machine scp mq/docker-compose.yml vm2:/home/docker/


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
docker-machine ssh ha1 " wget http://tinycorelinux.net/8.x/x86/tcz/haproxy.tcz"
docker-machine ssh ha1 "tce-load -i haproxy.tcz"
docker-machine ssh ha1 "haproxy --version"

docker-machine ssh ha1 "tce-load -w -i haproxy.tcz"
docker-machine create --driver virtualbox ha2

