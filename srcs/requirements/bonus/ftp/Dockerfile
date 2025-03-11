FROM alpine:3.21.1

ENV FTP_USER="ftpquoi"
ENV FTP_PASSWORD="ftpfeur"

RUN		apk update --no-cache						
RUN		apk add --no-cache							\
			vsftpd									\
			openrc									\
			bash									\
			strace

RUN		 adduser -h /var/www/wordpress -D $FTP_USER	
RUN		 echo $FTP_USER:$FTP_PASSWORD | chpasswd		

RUN		 mkdir -p /var/www/wordpress									
RUN		 chown -R $FTP_USER:$FTP_USER /var/www/wordpress

RUN		mkdir -p /var/log && touch /var/log/vsftpd.log && chmod 777 /var/log/vsftpd.log
RUN		mkdir -p /var/run/vsftpd/empty

COPY	conf/vsftpd.conf /etc/vsftpd/vsftpd.conf

RUN		 echo "local_enable=YES" >> /etc/vsftpd/vsftpd.conf			
RUN		 echo "write_enable=YES" >> /etc/vsftpd/vsftpd.conf			
RUN		 echo "chroot_local_user=YES" >> /etc/vsftpd/vsftpd.conf		
RUN		 echo "allow_writeable_chroot=YES" >> /etc/vsftpd/vsftpd.conf	
RUN		 echo "pasv_enable=YES" >> /etc/vsftpd/vsftpd.conf			
RUN		 echo "pasv_min_port=21000" >> /etc/vsftpd/vsftpd.conf		
RUN		 echo "pasv_max_port=21010" >> /etc/vsftpd/vsftpd.conf		
RUN		 echo "seccomp_sandbox=NO" >> /etc/vsftpd/vsftpd.conf		

CMD ["vsftpd", "/etc/vsftpd/vsftpd.conf"]
# copyright chayanne le goat