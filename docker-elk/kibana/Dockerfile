# https://github.com/elastic/kibana-docker
#FROM docker.elastic.co/kibana/kibana-oss:7.8.0
FROM docker.elastic.co/kibana/kibana:7.8.0
USER root
RUN /bin/cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && echo 'Asia/Shanghai' >/etc/timezone
USER kibana



# Add your kibana plugins setup here
# Example: RUN kibana-plugin install <name|url>
