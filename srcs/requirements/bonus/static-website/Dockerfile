FROM alpine:3.21.1

RUN		apk add --no-cache nginx &&	\
		mkdir -p /var/www/html

COPY	html /var/www/html

COPY	nginx/default.conf /etc/nginx/nginx.conf

CMD ["nginx", "-g", "daemon off;"]
