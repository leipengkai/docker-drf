# https://github.com/elastic/filebeat-docker
FROM docker.elastic.co/beats/filebeat-oss:7.8.0
USER root
RUN /bin/cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && echo 'Asia/Shanghai' >/etc/timezone

#COPY config/filebeat.yml /usr/share/filebeat/filebeat.yml
#RUN chown root:filebeat /usr/share/filebeat/filebeat.yml
USER filebeat
#RUN /usr/share/filebeat/filebeat modules enable nginx

# https://hub.docker.com/layers/elastic/filebeat/7.8.0/images/sha256-0ad9454bd06d448db412be137fda338831f8be7e33c603e5ad24d75dfbc3c380?context=explore

#RUN /usr/share/filebeat/filebeat setup --dashboards # 需要启动Kibana才能用

