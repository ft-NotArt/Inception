FROM alpine:3.21.1

WORKDIR	/tmp/cadvisor

RUN		apk update	--no-cache
RUN		apk add		--no-cache curl														\
		&& curl --create-dirs https://github.com/google/cadvisor/releases/download/v0.49.2/cadvisor-v0.49.2-linux-amd64 -L -o /tmp/cadvisor/cadvisor	\
		&& chmod +x cadvisor

CMD ["/tmp/cadvisor/cadvisor"]
