## build : docker build ./ -t frp
##


FROM alpine:3.9

LABEL maintainer="xiaofeng <251708339@qq.com>"
ARG TZ='Asia/Shanghai'
ARG Setup_Path='/opt/frp'

ENV TZ $TZ
ENV frp_url https://github.com/fatedier/frp/releases/download/v0.24.1/frp_0.24.1_linux_amd64.tar.gz
ARG frp_name='frp_0.24.1_linux_amd64'

#安装工具
RUN apk upgrade --update \
    && apk add bash tzdata libsodium \
    && apk add --virtual .build-deps \
		wget \
        curl \
        tar 

# 下载
RUN apk add bash tzdata libsodium \
    && apk add --virtual .build-deps \
	&& mkdir ${Setup_Path} \
	&& cd /tmp \
	&& wget ${frp_url} -O  frp.tar.gz





#解压
#RUN  cd /tmp \
#	&& tar -xzvf frp.tar.gz \
#	&& cp -r /tmp/${frp_name}/*  ${Setup_Path}/ \
#	&& cd ${Setup_Path} \
#	&& ls \
#	&& pwd

	
	
	#&& cp -r ./* ${Setup_Path} \
	#&& cd ${Setup_Path} \
	#&& ls /tmp/${frp_name} \
	#&& rm -rf /tmp/${frp_name}


#启动的环境变量
ENV Setup_Path $Setup_Path

#配置路径
ENV frp_config_file $Setup_Path/config/frp.ini
ENV frp_log_file $Setup_Path/log/frp.log

#如果没有host则为服务端，有则为客户端需要连接的地址
ENV s_host ""
#服务端监听的端口，或客户端连接的端口
ENV s_port "7000"
#客户端配置
ENV c_type "http"
ENV c_local_ip "127.0.0.1"
ENV c_local_port "8080"
ENV remote_port = 80







ADD entrypoint.sh /entrypoint.sh
RUN chmod -R 777 /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
