
此项目的[docker-compose.yml](https://github.com/leipengkai/docker-drf/blob/master/docker-elk/docker-compose.yml)

### ELK处理流程图
<center>![flek处理流程](https://i.loli.net/2020/07/10/MJczribtCwnTsWY.png "flek处理流程" )</center>

流程:

1. filebeat<strong>采集</strong>日志,并发送到logstash(可发送到消息队列中:redis,kafaka).
2. logstash利用filter等工具<strong>过滤,修改,分析</strong>日志,处理后,再发送到elasticsearch.
3. elasticsearch按不同的索引(index)来<strong>存储,索引</strong>日志,<strong>组成一个全文搜索服务</strong>
4. kibana连接到ES日志内容,<strong>展示</strong>出来

功能:

- [filebeat](https://www.elastic.co/beats/filebeat):采集日志,以本地文件日志居多
    - 可发送到消息队列中(redis,kafaka)缓存,也可直接发送到logstash
    - 以增量读取的方式发送日志
    - 简单安装在各种服务器上的
- [Logstash](https://www.elastic.co/cn/products/logstash):采集日志,docker,本地文件,接收filebeat输出等方式收集
    - 通过logstash.conf来过滤和解析我们想要的log,并可将其存储供以后使用
    - [使用Logstash](https://doc.yonyoucloud.com/doc/logstash-best-practice-cn/get_start/index.html)
- [Elasticsearch](https://www.elastic.co/):Logstash将收集到的log,交给Elasticsearch进行索引(index),组成一个全文搜索服务
    - 用[ es head chrome extension 插件](https://chrome.google.com/webstore/detail/elasticsearch-head/ffmkiejjmecolpfloofpjologoblkegm)
        - 来查看es 集群状态和日志信息
        - 安装好后,只需点一下图标,再连接ES即可: http://localhost:9200/
- [Kibana](https://www.elastic.co/products/kibana):Logstash和ElasticSearch提供的日志分析友好的Web界面,帮助汇总、分析和搜索重要数据日志
 

#### 启动ELK日志系统
```bash
cd docker-elk

# 创建images,第一次时执行
docker-compose build

# 服务器内存最好有3G以上
# 启动项目,ELK日志系统
docker-compose up

# 确认是否正确启动服务
docker-compose ps

# 将一些nginx josn格式的日志放入到,下面这个文件中
../Dockerfiles/nginx/log/access.log
# Dockerfiles目录与docker-elk目录同级,eg:

# 手动追加,多行为一行
cat <<EOF >> ~/Downloads/github/docker-drf/Dockerfiles/nginx/log/access.log
{ "time_local": "12/Jul/2020:11:29:01 +0800", "remote_addr": "172.27.0.1", "referer": "http://127.0.0.1/api/v1/goods/", \
"request": "GET /api/v1/goods/echo_test?page=2 HTTP/1.1", "status": 200, "bytes": 6586, \
"http_user_agent": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_5) AppleWebKit/537.36 (KHTML, like Gecko) \
Chrome/83.0.4103.116 Safari/537.36", "x_forwarded": "", "up_addr": "unix:/code/app.sock","up_host": "",\
"upstream_time": "1.206","request_time": "1.206","host":"172.27.0.6","http_host":"127.0.0.1","tcp_xff":""}
EOF

```

#### 正确启动后,开启的端口
| 端口 | 说明 |
| :------: | :------: | 
| 5044 | Logstash TCP input(6.1.0是5000) |
| 9600 | Logstash UDP input(6.1.0是12201)|
| 9200 |用[ es head chrome extension 插件](https://chrome.google.com/webstore/detail/elasticsearch-head/ffmkiejjmecolpfloofpjologoblkegm)连接: http://localhost:9200/|
| 9300 | Elasticsearch TCP transport,没使用|
| 5601 | [Kibana](http://localhost:5601/)|
| 5601 | [Kibana status](http://localhost:5601/status)|
| elk认证 | 用户名/密码: elastic/changeme |
| elk版本 | 基础(默认)版本:7.8.0版本 |


## 说明

#### filebeat

注意:
- filebeat只能有一个output,不管什么类型
- 启动时,只会找默认目录(自己另外指定失败)下的,filebeat.yml文件
- 日志文件,不用用ln过来的
- 对日志文件,增量读取


#### logstash

- 模拟向Logstash发送log

```
# 将保存在test-*的Index下
echo 'hello world' > 2.md
nc localhost 9600 < 2.md
rm 2.md
# 注意echo ‘hello world' > nc localhost 9600 这种方式发送失败

打开: es head chrome extension 这个插件,就可以看到test-*这个索引的内容

```

- 将非json格式的nginx日志,转成json格式

```
# 靠filebeat采集数据到Logstash,Logstash再进行grok转换成json格式
# 数据很大的话grok转换成json格式挺耗资源的,所以都是事先将日志通过程序转换成json格式
nginx_text_to_json.py
```

- 日志产生时间替换@timestamp(日志输入时间)

```
logstash.conf
filter {
    grok {
    }
    date {
    }
}
```

#### ES


开源(Apache2.0): oss版本
- ERROR: X-Pack is not available with the oss distribution; to use X-Pack features use the default distribution

基础级: 即默认版本,非oss版本

- x-pack: 一个集安全,警报,监视,报告和图形功能于身的扩展
    - 开源版本没有
    - 6.6.1版本后x-pack已经默认安装
    - x-pack:使用basic版本的安全(Security)功能,7.1之后可以免费使用.可能是被[破解](https://www.ipyker.com/2019/03/13/elastic-x-pack)搞怕了
    - x-pack其它功能需要订阅,也就是trial license:30天试用

- 设置密码,[elastic版本说明](https://www.elastic.co/cn/subscriptions)
    - 生成认证文件:
    ```
    docker-compose down
    
    docker run -it --rm --name es docker.elastic.co/elasticsearch/elasticsearch:7.8.0 bash

    # 下面这两个命令,直接回车,不要输入密码🤣🤣. 我之前加了启动es时,一直报错😰😰😰
    ./bin/elasticsearch-certutil ca
    ./bin/elasticsearch-certutil cert --ca elastic-stack-ca.p12
    
    # 在另一个终端
    cd ~/Downloads/github/docker-drf/docker-elk/elasticsearch/config
    docker cp es:/usr/share/elasticsearch/elastic-certificates.p12 .
    docker cp es:/usr/share/elasticsearch/elastic-stack-ca.p12 .
    
    # 退出容器
    ```

    - 设置集群密码,此密码将会用在ELK整个集群上:
    ```
    # 启动要设置密码的容器
    docker-compose up elasticsearch

    docker exec -it elasticsearch bash
    # 手动输入密码
    ./bin/elasticsearch-setup-passwords interactive

    输入:y
    然后是多个用户包括: apm_system, kibana_system, kibana, logstash_system, beats_system, remote_monitoring_user, elastic
    我使用的密码是: elastic

    # 创建一个superuser
    ./bin/elasticsearch-users useradd parker -r superuser

    ```
    
    - 修改集群密码
    ```
    # 启动es
    docker-compose up elasticsearch
    # 修改密码,需要记得之前的密码
    # 把密码改成 hello ,chrome对http://127.0.0.1:5601,elastic:elastic,会跳出,在密码外泄列表上的警告框
    curl -H "Content-Type:application/json" -XPOST -u elastic 'http://127.0.0.1:9200/_xpack/security/user/elastic/_password' -d '{ "password" : "changeme"  }'

    # 忘记密码时,使用superuser进行重置密码
    curl -H "Content-Type:application/json" -XPOST -u parker:parker 'http://127.0.0.1:9200/_xpack/security/user/elastic/_password' -d '{ "password" : "changeme"  }'
    ```
    - elk其它组件的[配置文件的修改]( https://blog.csdn.net/qq_41980563/article/details/88725584)
    - 如果是从oss版本换到非oss版本的,请清除一下chrome的浏览记录,不然可能会打不开http://127.0.0.1:5601
- 启动SSL,需要订阅:[docker compose elasticsearch dns ssl](https://www.elastic.co/guide/en/elasticsearch/reference/current/configuring-tls-docker.html)

#### kibana


- 使用命令创建索引

```bash
# 为Kibana创建一个index pattern
curl -u elastic:changeme -XPOST -D- "http://localhost:5601/api/saved_objects/index-pattern" \
    -H "Content-Type: application/json" \
    -H "kbn-version: 7.8.0" \
    -d "{\"attributes\":{\"title\":\"test-*\",\"timeFieldName\":\"@timestamp\"}}"
# 此命令,是强制创建index,即使ES中没有对应的索引.而在kibana管理面板是不能强制创建的



# 为了 docker-elk/logstash/pipeline/logstash.conf-->index => "nginx",而创建
curl -u elastic:changeme -XPOST -D- "http://localhost:5601/api/saved_objects/index-pattern" \
    -H "Content-Type: application/json" \
    -H "kbn-version: 7.8.0" \
    -d "{\"attributes\":{\"title\":\"nginx*\",\"timeFieldName\":\"@timestamp\"}}"
```

视图类:

- kibana使用地图展示nginx客户端IP区域

```bash
1. 注册并下载包[GeoLite2 City](https://dev.maxmind.com/geoip/geoip2/geolite2/)
解压后得到GeoLite2-City.mmdb, 挂载到logstash下

2. does not contain any of the following compatible field types: geo_point
output到elasticsearch的index必须是以"logstash-"开头的，修改后问题就解决了. eg:logstash-nginx-access-*


3. 但原来的json格式却没了, 加个判断:
    if "access" in [tags] {      
        geoip {
        }
    }

4. 进入kibana-->index(logstash-nginx-access-*)-->Dashboards-->create-->map-->\
    count(Metrics)-->加Buckets-->Aggregation:Geohash-->Field:geoip.location-->update-->选择1天-->save
# 范围不要选太大了,我选了一年的,结果只能点最多的,其它的根本就点不了,还以为不对呢
```
<center>![kibana展示ip位置](https://i.loli.net/2020/07/09/RGcqQEp8SxDYf17.png "kibana展示ip位置")</center>

- url访问前10

<center>![访问URL 前10](https://i.loli.net/2020/07/10/iO1ZlTHybg2CaW6.png "访问URL 前10" )</center>
 
```bash
{"query": 
    {"bool": 
        {"must_not": 
            [
            {"match": { "request": "robots.txt" } },
            {"match": { "request": "ftptest.cgi" } },
            {"match": { "request": "login.cgi" } },
            ]
        }
    }
}

```

- [kibana制作nginx平均响应时间](https://blog.csdn.net/u010603691/article/details/79310495)

#### [Metricbeat](https://www.elastic.co/guide/en/beats/metricbeat/current/index.html)

- 启动Metricbeat 监控,也是basic免费版本的功能 😘😘

```
# 之前还有疑问:好像要订阅,但我已经是用basic,没用trail啊,为什么给我也在kibana显示出来

# 拷贝模板到主机上
docker run -it --rm --name metricbeat1 docker.elastic.co/beats/metricbeat:7.8.0  bash

docker images |grep metricbeat
cd ~/Downloads/github/docker-drf/docker-elk/metricbeat 

docker cp metricbeat1:/usr/share/metricbeat/modules.d ./

退出 单个的metricbeat1容器

# 启动项目
docker-compose build
docker-compose up

# 启动插件
docker exec metricbeat1 ./metricbeat modules enable elasticsearch-xpack
docker exec metricbeat1 ./metricbeat modules list

# Enable the collection of monitoring data:
https://www.elastic.co/guide/en/elasticsearch/reference/7.8/configuring-metricbeat.html
# 点击"View in Console",会进入到localhost:5601的命令行Console,直接运行命令即可
# 其它的不需要,即可得到下图的效果

```
<center>![elk-metricbeat监控](https://i.loli.net/2020/07/12/eJ3iNqcysAWwznC.gif "elk-metricbeat监控")</center>

#### 整合到[docker-compose.yml](https://github.com/leipengkai/docker-drf/blob/master/Dockerfiles/docker-compose.yml)中

- 在docker-compose.yml中的web服务加上如下代码
```bash
      logging:
        driver: syslog
        options:
            syslog-address: tcp://0.0.0.0:5044
            tag: web-container-tcp
      # 注意加上之后,pycharm控制台中就不会显示log了,查看日志:http://localhost:5601/
```
- 如果项目的settings.py中不设置LOGGING,则使用默认的



参考:

[docker-elk](https://github.com/twtrubiks/docker-elk-tutorial)


快速上手基础版本的elk日志系统,包括kibana的geoip,ES的认证功能


## 其它测试,可跳过

```bash
# 为了避免使用到之前的版本,先build
docker-compose build
# 启动
docker-compose up

docker-compose down之后再up
会重新加入filebeat-->logstast-->es-->kibana



######################################################
由于filebeat-->ES,才能使用filebeat的内置模块.已经实现geoip了,不需要了
只是为测试

# 之后,只要这两句就行了
docker exec -it filebeat bash
filebeat setup --dashboards 



ln -sv ~/Downloads/modules_access.log ./github/docker-drf/elk/logs/nginx/modules_access.log
# ln文件可以被正常输入

# 只能使用绝对路径,才能成功
ln -sv ~/Downloads/github/docker-drf/docker-elk/json_access.log logs/nginx
ln -sv ~/Downloads/github/docker-drf/docker-elk/error.log logs/nginx
# 不能用ln的方式,之前是有一个实体文件在,导致以为使用ln也可以.
# 导致我一直看不到日志的输入,我去



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
filebeat modules disable nginx
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
