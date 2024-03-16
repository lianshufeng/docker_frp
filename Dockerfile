## build : docker build ./ -t frp
##


FROM alpine:3.19
RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories

LABEL maintainer="xiaofeng <251708339@qq.com>"
ARG TZ='Asia/Shanghai'
ARG Setup_Path='/opt/frp'

ENV TZ $TZ
ENV frp_version 0.55.1
ENV frp_url https://github.com/fatedier/frp/releases/download/v${frp_version}/frp_${frp_version}_linux_amd64.tar.gz
ENV frp_name frp_${frp_version}_linux_amd64

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


#解压文件
RUN cd /tmp \
	&& tar -xzvf frp.tar.gz \
	&& cd /tmp/${frp_name} \
	&& cp -r /tmp/${frp_name}/* ${Setup_Path}/ \
	&& chmod -R 777 ${Setup_Path}/ \
	&& rm -rf frp.tar.gz \
	&& rm -rf /tmp/${frp_name}


#工作目录
WORKDIR /opt/frp


#启动命令行
ENV entrypoint ""


ADD entrypoint.sh /entrypoint.sh
RUN chmod -R 777 /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

