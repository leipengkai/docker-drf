[具体教程请参考这里](https://github.com/twtrubiks/docker-elk-tutorial)
[可以在这里学习elk](https://doc.yonyoucloud.com/doc/logstash-best-practice-cn/get_start/index.html)

### ELK处理流程图
![elk处理流程图](./elk处理流程图.png)
- [Logstash](https://www.elastic.co/cn/products/logstash):Logstash从docker或者其它地方收集log,通过[logstash.conf](./logstash/pipeline/logstash.conf)来过滤和解析我们想要的log,并可将其存储供以后使用
- [Elasticsearch](https://www.elastic.co/):Logstash将收集到的log,交给Elasticsearch进行索引(index),组成一个全文搜索服务
- [Kibana](https://www.elastic.co/products/kibana):Logstash和ElasticSearch提供的日志分析友好的Web界面,帮助汇总、分析和搜索重要数据日志
- filebeat采集日志,然后发送到消息队列,redis，kafaka.然后logstash去获取,利用filter功能过滤分析,然后存储到elasticsearch中
 

#### 启动ELK日志系统
```bash
cd docker-elk

# 创建images,第一次时执行
docker-compose build

# 启动ELK日志系统
docker-compose up

# 确认是否正确启动服务
docker-compose ps
```
#### 正确启动后,开启的端口
| 端口 | 说明 |
| :------: | :------: | 
| 5000 | Logstash TCP input |
| 12201 | Logstash UDP input|
| 9200 | [Elasticsearch HTTP](http://localhost:9200/)|
| 9300 | Elasticsearch TCP transport|
| 5601 | [Kibana](http://localhost:5601/)|

#### Kibana简单查看log
```bash
# 为Kibana创建一个index pattern
curl -XPOST -D- "http://localhost:5601/api/saved_objects/index-pattern" \
    -H "Content-Type: application/json" \
    -H "kbn-version: 6.1.0" \
    -d '{"attributes":{"title":"logstash-*","timeFieldName":"@timestamp"}}’

# 模拟向Logstash发送log,默认保存在logstash-*的Index下
echo 'hello world' > 2.md
nc localhost 5000 < 2.md
# 注意echo ‘hello world' > nc localhost 5000 这种方式发送失败

打开:http://localhost:5601/-->Kibana—Discover—message 可看到刚刚发送的信息


# 为了 docker-elk/logstash/pipeline/logstash.conf-->index => "nginx",而创建
curl -XPOST -D- "http://localhost:5601/api/saved_objects/index-pattern" \
    -H "Content-Type: application/json" \
    -H "kbn-version: 6.1.0" \
    -d "{\"attributes\":{\"title\":\"nginx*\",\"timeFieldName\":\"@timestamp\"}}"
```

#### 整合到[docker-compose.yml](../Dockerfiles/docker-compose.yml)中
- 在docker-compose.yml中的web服务加上如下代码
```bash
      logging:
        driver: syslog
        options:
            syslog-address: tcp://0.0.0.0:5000
            tag: web-container-tcp
      # 注意加上之后,pycharm控制台中就不会显示log了,查看日志:http://localhost:5601/
```
- 如果项目的settings.py中不设置LOGGING,则使用默认的


### filebeat --> logstash --> ES -->kibana

```bash
# 为了避免使用到之前的版本,先build
docker-compose build
# 启动
docker-compose up



######################################################
由于filebeat-->ES,才能使用filebeat的内置模块,只是为测试

# 之后,只要这两句就行了
docker exec -it filebeat bash
filebeat setup --dashboards 



ln -sv ~/Downloads/modules_access.log ./github/docker-drf/elk/logs/nginx/modules_access.log
# ln文件可以被正常输入

# 将modules.d保存到本地,再映射到容器
docker run -it --rm --name test1 docker.elastic.co/beats/filebeat-oss:7.8.0  bash

cd ~/Downloads/github/docker-drf/elk/filebeat 

docker cp test1:/usr/share/filebeat/modules.d ./

# filebeat modules enable nginx 等于下面这行命令
# mv modules.d/nginx.yml.disabled modules.d/nginx.yml

vim modules.d/nginx.yml
    - module: nginx
      access:
        enabled: true
        #var.paths: ["/usr/share/filebeat/mylogs/nginx/access.log"]
        var.paths: ["/usr/share/filebeat/mylogs/nginx/modules_access.log"]
      error:
        enabled: true
        var.paths: ["/usr/share/filebeat/mylogs/nginx/error.log"]

# 启动
cd ../
docker-compose up




# 启动filebeat内置模块
docker exec -it filebeat bash
filebeat modules enable nginx
filebeat modules list

filebeat setup --dashboards 
# 在kibana创建一个 filebeat-* 的index  *,记得先删除之前的
进入kibana-->Dashboards-->搜索nginx

filebeat test output
# ok

filebeat -e
# Exiting: data path already locked by another beat. 也没关系


由于filebeat-->ES,才能使用filebeat的内置模块,只是为测试
######################################################
```
