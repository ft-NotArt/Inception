FROM	alpine:3.21.2

RUN		apk update --no-cache						\
\
		&& apk add --no-cache						\
			mariadb									\
			mariadb-client							\
			gettext-envsubst						\
\
		&& mkdir -p									\
			/var/lib/mysql							\
			/run/mysqld								\
\
		&& chown -R mysql:mysql						\
			/var/lib/mysql							\
			/run/mysqld								\
\
		&& mariadb-install-db						\
			--user=mysql							\
			--datadir=/var/lib/mysql

COPY	conf/mariadb.conf	/etc/mysql/mariadb.conf.d/mariadb.conf
COPY	tools/init.sql tools/init.sql
COPY	tools/init_sql.sh tools/init_sql.sh
RUN		chmod +x /tools/init_sql.sh

EXPOSE	3306

USER	mysql

ENTRYPOINT ["/tools/init_sql.sh"]
