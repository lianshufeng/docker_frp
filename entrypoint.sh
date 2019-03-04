#!/bin/bash

#刷新环境变量
source /etc/profile


#生成配置文件与日志文件
frp_config_path=${frp_config_file%/*}
frp_log_path=${frp_log_file%/*}
mkdir -p $frp_config_path
mkdir -p $frp_log_path



#应用程序的路径
appPath=""
if [[ $s_host == "" ]]; then
	appPath=$Setup_Path/frps
else
	appPath=$Setup_Path/frpc
fi





if [ ! -f $frp_config_file ];then
	echo "文件不存在"
fi

echo "run ->>>>>>>>>>>"
cd $Setup_Path
ls




echo "app:"$appPath

nohup ${appPath} -c ${frp_config_file}