#FROM docker.elastic.co/beats/metricbeat-oss:7.8.0
FROM docker.elastic.co/beats/metricbeat:7.8.0
USER root
RUN /bin/cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && echo 'Asia/Shanghai' >/etc/timezone

#COPY config/metricbeat.yml /usr/share/metricbeat/metricbeat.yml
#RUN chown root:metricbeat /usr/share/metricbeat/metricbeat.yml
USER metricbeat
#RUN /usr/share/metricbeat/metricbeat modules enable nginx

# https://hub.docker.com/layers/elastic/metricbeat/7.8.0/images/sha256-8bb8c18b8d7f9503f094c059714eeca6fe625420d84a79a528443e8836b66909?context=explore

