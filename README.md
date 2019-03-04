## pull
````shell
docker pull lianshufeng/frp
````

## simple
- server
````shell
sudo firewall-cmd --add-port=7000/tcp --permanent 
sudo firewall-cmd --add-port=80/tcp --permanent 
firewall-cmd --reload 
docker run --name frps  -p 7000:7000 -p 80:80  lianshufeng/frp
````
- client 
````shell
docker run --name frpc -e type=c -e s_port=7000 -e s_host=192.168.150.135 -e c_local_ip=192.168.31.222  -e c_local_port=8080 -e remote_port=80 lianshufeng/frp
````

## 
docker run -v /opt/frp:/opt/frp --name frps  -p 7000:7000 -p 80:80  lianshufeng/frp
