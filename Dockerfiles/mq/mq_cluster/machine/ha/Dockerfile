FROM haproxy

ENV KEEPALIVED_VERSION 1:1.2.13-1
ENV HAPROXY_USER haproxy

RUN apt-get update && apt-get -y upgrade && \
    apt-get install --no-install-recommends --no-install-suggests -y keepalived && \
    apt-get install -y net-tools iputils-ping vim initscripts procps && \
    rm -rf /var/lib/apt/lists/*
    # apt-get install --no-install-recommends --no-install-suggests -y keepalived=${KEEPALIVED_VERSION} && \
    # apt-get install -y keepalived=${KEEPALIVED_VERSION} && \


RUN groupadd --system ${HAPROXY_USER} \
    && useradd --system --gid ${HAPROXY_USER} ${HAPROXY_USER} \
    && mkdir -p /var/lib/${HAPROXY_USER} \
    && chown -R ${HAPROXY}:${HAPROXY_USER} /var/lib/${HAPROXY_USER}

COPY haproxy.cfg /usr/local/etc/haproxy/haproxy.cfg
# COPY keepalived.conf /etc/keepalived/keepalived.conf
COPY ./docker-entrypoint-override.sh /docker-entrypoint-override.sh
ADD ./keepalived /keepalived

RUN chmod +x /docker-entrypoint-override.sh
RUN chmod +x /keepalived/*.sh

ENTRYPOINT ["/docker-entrypoint-override.sh"]

CMD ["haproxy", "-f", "/usr/local/etc/haproxy/haproxy.cfg"]
