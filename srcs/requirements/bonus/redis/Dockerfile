FROM alpine:3.21.1

RUN		apk update --no-cache						\
		&& apk add --no-cache redis

RUN		sed -i 's/^# *maxmemory <bytes>/maxmemory 256mb/' /etc/redis.conf	\
		&& sed -i 's/^# *maxmemory-policy noeviction/maxmemory-policy allkeys-lru/' /etc/redis.conf	\
		&& sed -i -r "s/bind 127.0.0.1/#bind 127.0.0.0/" /etc/redis.conf

RUN		mkdir -p /data								\
		&& chown redis:redis /data

VOLUME	/data

USER	redis

CMD ["redis-server", "--protected-mode", "no", "--dir", "/data"]
