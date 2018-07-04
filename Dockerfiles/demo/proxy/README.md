```bash
proxy_pass http://myapp; #是services_name

# 创建多个服务
 docker-compose scale -h
docker-compose scale myapp=4

# 运行
docker-compose up

# 查看容器
docker exec -it demo_proxy_1 sh
/ nslookup myapp
/ ping myapp
/ mount
/ more /etc/resolv.conf

docker-compose scale myapp=2

```
