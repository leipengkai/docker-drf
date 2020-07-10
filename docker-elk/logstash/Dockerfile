# https://github.com/elastic/logstash-docker
#FROM docker.elastic.co/logstash/logstash-oss:7.8.0
FROM docker.elastic.co/logstash/logstash:7.8.0
#ENV TZ=Asia/Shanghai
#RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
USER root
RUN /bin/cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && echo 'Asia/Shanghai' >/etc/timezone
# https://github.com/elastic/dockerfiles/blob/7.8/logstash/Dockerfile
USER 1000

# Add your logstash plugins setup here
# Example: RUN logstash-plugin install logstash-filter-json
