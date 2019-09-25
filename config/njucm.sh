#!/bin/sh

# 输入格式：登录类型(in、out)，运营商(ctcc-电信、cmcc-移动、cucc-联通、njucm-校园网)，账号，密码

# 登录类型
logintype=$1

# 运营商
isp=$2

# 账号
name=$3

# 密码
pwd=$4

# 运营商标识
loginisp=

# 执行登录操作
if [ "$logintype" = "in"  ]
then
	printf "执行登录操作！\n\n"
	
	# 获取运营商标识
	# 移动
	if [ "$isp" = "cmcc" ] 
	then
		loginisp=cmcc
		printf "当前是移动网！\n\n"
	# 联通
	elif [ "$isp" = "cucc" ] 
	then
		loginisp=jsunicom
		printf "当前是联通网！\n\n"
	# 电信
	elif [ "$isp" = "ctcc" ]
	then
		loginisp=chinanet
		printf "当前是电信网！\n\n"
	# 校园网
	elif [ "$isp" = "njucm" ] 
	then
		loginisp=njucm-mac
		printf "当前是校园网！\n\n"
	else
		printf "运营商错误！\n\n"
		exit 0
	fi
		
	##########################################

	# 账号不为空
	if [ ${name} ]
	then
		loginname=${name}
		echo "账号为：$loginname"
		echo ""
	else
		printf "账号为空！\n\n"
		exit 0
	fi
	
	##########################################
	
	# 密码不为空
	if [ ${pwd} ]
	then
		# 加密
		loginpwd=$( printf "%s" $pwd | base64 )
		echo "密码为：$loginpwd"
		echo ""
	else
		printf "密码为空！\n\n"
		exit 0
	fi
	
	##########################################
	
	# 登录操作
	curl "http://10.10.100.12/index.php/index/login" --data "username=${loginname}&domain=${loginisp}&password=${loginpwd}&enablemacauth=0"
	
# 执行退出操作
elif [ "$logintype" = "out" ] 
then
	printf "执行退出操作！\n\n"
	
	# 退出操作
	curl "http://10.10.100.12/index.php/index/logout"
	
# 什么都不做
else
	printf "参数错误！\n\n"
	exit 0
fi