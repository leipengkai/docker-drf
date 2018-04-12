FROM redis
#COPY redis.conf /usr/local/etc/redis/redis.conf
#RUN chmod 755 /usr/local/etc/redis/redis.conf 
	#&& chmod 755 /var/log/redis/redis-server.log \
	#&& chmod 755 /var/lib/redis

# Define mountable directories.
VOLUME ["/data"]

# Define working directory.
WORKDIR /data

# Define default command.
CMD [ "redis-server", "/usr/local/etc/redis/redis.conf" ]

# Expose ports.
EXPOSE 6379
