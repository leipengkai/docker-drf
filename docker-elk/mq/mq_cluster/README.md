### mq服务使用HaProxy进行负载均衡
#### 注意docker-compose.yml使用的是haproxy2这个镜像

- 运行容器

```bash
cd mq_cluster
docker-compose up

```
- mq镜像集群
    - 三台机器人的mq实例所有属性都一样
    - 创建了三个mq实例,模拟三台机器,并已经加入集群
    - 设置成镜像集群:

    ```bash

    # 创建mq镜像集群
    # 在任意一个mq_ui: http://0.0.0.0:15673/#/ -->Admin -->Policies-->Add/update a policy

    # 或者使用命令:但我这里是失败的 
    docker exec -it rabbitmq-node-3 bash "rabbitmqctl set_policy  mq_cluster "^" '{"ha-mode":"all"}'"
    ```

|主机名|容器名|端口| 说明 |
|---|---|---|---|
| rabbitmq-node-1 | rabbitmq-node-1  | 15673:15672(宿主:容器)/5673:5672  |  |
| rabbitmq-node-2 | rabbitmq-node-2  | 15674:15672(宿主:容器)/5674:5672  |  |
| rabbitmq-node-3 | rabbitmq-node-3  | 15675:15672(宿主:容器)/5675:5672  |  | |


- haproxy说明

|内容|说明|注意|
|---|---|---|
|haproxy.cfg |[haproxy.cfg配置说明](https://www.lijiaocn.com/%E6%8A%80%E5%B7%A7/2017/06/26/haproxy-usage.html)|1.haproxy不要为latest,我选的是1.7.3<br>2.在默认设置时,必须设置成tcp mode<br>3.监控页面的listen设置成监控所有|
|haproxy监控页面 |[haproxy监控页面](http://0.0.0.0:1936/stats)| 1936:1936(宿主:容器),http |
|haproxy负载mq_ui |[mq_ui页面](http://0.0.0.0:15676)| 15676:15676(宿主:容器), http |
|haproxy负载mq服务 |对mq实例服务进行负载| 5676:5676(宿主:容器),tcp |


- docker rabbitmq命令

``` bash
# 加入集群
docker exec -it rabbitmq-node-2 bash -c "rabbitmqctl stop_app"
docker exec -it rabbitmq-node-2 bash -c "rabbitmqctl join_cluster rabbit@rabbitmq-node-1"
docker exec -it rabbitmq-node-2 bash -c "rabbitmqctl start_app"


# 加入集群
docker exec -it rabbitmq-node-3 bash -c "rabbitmqctl stop_app"
docker exec -it rabbitmq-node-3 bash -c "rabbitmqctl join_cluster rabbit@rabbitmq-node-1"
docker exec -it rabbitmq-node-3 bash -c "rabbitmqctl start_app"


# 退出集群命令
rabbitmqctl stop_app
rabbitmqctl reset
rabbitmqctl start_app
```

- 验证Haproxy负载成功

```bash
cd haproxy2

python revc.py
python send.py
# 这两个py文件,是通过haproxy负载的设置: '0.0.0.0',5676
# 可以通过mq_ui:  http://0.0.0.0:15676/#/ . 看到消息的发送状态
```
