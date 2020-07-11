# https://github.com/elastic/elasticsearch-docker
#FROM docker.elastic.co/elasticsearch/elasticsearch-oss:7.8.0
FROM docker.elastic.co/elasticsearch/elasticsearch:7.8.0
RUN /bin/cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && echo 'Asia/Shanghai' >/etc/timezone

# https://hub.docker.com/_/elasticsearch?tab=tags
# Add your elasticsearch plugins setup here
# Example: RUN elasticsearch-plugin install analysis-icu
