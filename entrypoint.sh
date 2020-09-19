#!/bin/sh

#刷新环境变量
source /etc/profile

cmd="${entrypoint}"
echo "cmd : "$cmd
${cmd}