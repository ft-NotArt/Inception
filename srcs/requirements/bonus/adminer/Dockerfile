FROM	alpine:3.21.2

RUN		apk add --no-cache php php-mysqli php-session php-json wget

RUN		mkdir -p /var/www/html &&	\
		wget -O /var/www/html/index.php https://www.adminer.org/latest.php

EXPOSE	600

CMD	["php", "-S", "0.0.0.0:80", "-t", "/var/www/html"]