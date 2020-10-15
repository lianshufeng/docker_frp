- pull
````shell
docker pull registry.cn-chengdu.aliyuncs.com/1s/frp
````


### frps
- docker-compose.yml
````shell 
version: "3"

services:
  frps:
    image: registry.cn-chengdu.aliyuncs.com/1s/frp
    ports:
      - "80:80" 
      - "443:443"
      - "7000:7000" 
      - "7500:7500" #控制台
      - "9000-9100:9000-9100"
    volumes:
      - "./frps.ini:/opt/frp/frps.ini"
      - "./logs:/opt/frp/logs"
    container_name: frps
    restart: always
    environment:
      - entrypoint=./frps -c frps.ini
````
- frps.ini
````shell
[common]
# A literal address or host name for IPv6 must be enclosed
# in square brackets, as in "[::1]:80", "[ipv6-host]:http" or "[ipv6-host%zone]:80"
bind_addr = 0.0.0.0
bind_port = 7000

# udp port to help make udp hole to penetrate nat
bind_udp_port = 7001

# udp port used for kcp protocol, it can be same with 'bind_port'
# if not set, kcp is disabled in frps
kcp_bind_port = 7000

# specify which address proxy will listen for, default value is same with bind_addr
# proxy_bind_addr = 127.0.0.1

# if you want to support virtual host, you must set the http port for listening (optional)
# Note: http port and https port can be same with bind_port
vhost_http_port = 80
vhost_https_port = 443

# response header timeout(seconds) for vhost http server, default is 60s
# vhost_http_timeout = 60

# set dashboard_addr and dashboard_port to view dashboard of frps
# dashboard_addr's default value is same with bind_addr
# dashboard is available only if dashboard_port is set
dashboard_addr = 0.0.0.0
dashboard_port = 7500

# dashboard user and passwd for basic auth protect, if not set, both default value is admin
dashboard_user = admin
dashboard_pwd = xiaofeng

# dashboard assets directory(only for debug mode)
# assets_dir = ./static
# console or real logFile path like ./frps.log
log_file = ./logs/frps.log

# trace, debug, info, warn, error
log_level = info

log_max_days = 3

# auth token
token = xiaofengfeng

# 域名,http协议必填
#subdomain_host = dzurl.top
````


### frpc
- docker-compose.yml
````shell
version: "3"

services:
  frps:
    image: registry.cn-chengdu.aliyuncs.com/1s/frp
    volumes:
      - "./frpc.ini:/opt/frp/frpc.ini"
      - "./logs:/opt/frp/logs"
    container_name: frpc
    restart: always
    environment:
      - entrypoint=./frpc -c frpc.ini
````
- frpc.ini
````shell
[common]
server_addr = 192.168.31.1
server_port = 7000

# console or real logFile path like ./frpc.log
log_file = ./logs/frpc.log

# trace, debug, info, warn, error
log_level = info

log_max_days = 3

# for authentication
token = xiaofengfeng

# if tcp stream multiplexing is used, default is true, it must be same with frps
tcp_mux = true

# communication protocol used to connect to server
# now it supports tcp and kcp and websocket, default is tcp
protocol = tcp

# if tls_enable is true, frpc will connect frps by tls
tls_enable = true

subdomain_host = dzurl.top

[web]
type = http
local_ip = 192.168.31.222
local_port = 8080
use_encryption = false
use_compression = true
subdomain = pc
# 子域名+域名 =  pc.dzurl.top

[web_tcp]
type = tcp
local_ip = 192.168.31.222
local_port = 8080
remote_port = 9000
use_encryption = false
use_compression = true
````

 

- firewall
 ````shell
sudo firewall-cmd --add-port=7000/tcp --permanent 
sudo firewall-cmd --add-port=80/tcp --permanent 
sudo firewall-cmd --permanent --zone=public --add-port=9000-9999/tcp
sudo firewall-cmd --reload 
 ````