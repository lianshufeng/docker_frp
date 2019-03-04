#!/bin/bash

#刷新环境变量
source /etc/profile


#如果目标目录没有文件，则解压
if [[ $(ls $Setup_Path -l |grep '^-'|wc -l) -eq 0 ]] ; then
	echo "copy new file : -------> "
	cd /tmp 
	tar -xzvf frp.tar.gz 
	cd /tmp/${frp_name}
	cp -r /tmp/${frp_name}/* ${Setup_Path}/
	
	#首次生成默认的配置文件
	if [[ $type == "s" ]]; then
cat <<EOF > $Setup_Path"/frps.ini"
[common]
token = ${token}
bind_port = ${s_port}
EOF
	else
cat <<EOF > $Setup_Path"/frpc.ini"
[common]
token = ${token}
server_addr = ${s_host}
server_port = ${s_port}

[${c_type}]
type = ${c_type}
local_ip = ${c_local_ip}
local_port = ${c_local_port}
remote_port = ${remote_port}
EOF
	fi

fi



#应用程序的路径
appPath=""
confPath=""
if [[ $type == "s" ]]; then
	appPath=$Setup_Path/frps
	confPath=$Setup_Path"/frps.ini"
	
else
	appPath=$Setup_Path/frpc
	confPath=$Setup_Path"/frpc.ini"
fi



cmd="nohup ${appPath} -c ${confPath}"
echo "cmd:"$cmd
${cmd}