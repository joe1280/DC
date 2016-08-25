#!/bin/bash
rm -rf ./ymcmlb
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
export PATH #DC云™
clear;
key=sivpn.com;
echo -e "\033[35m=========================================================================\033[0m"
echo -e "\033[33m                      DC云一键综合脚本8.17日\033[0m"
echo ""
echo -e "\033[31m                      【DC云官网sivpn.com】\033[0m"
echo ""
echo ""
echo -e "\033[31m                     云免交流QQ群：130097478\033[0m"
echo -e "\033[33m                          免费开放使用\033[0m"
echo ""
echo -e "\033[35m==========================================================================\033[0m"
	if [ mod=1 ]
	then
echo -e "\033[34m请选择安装版本：\033[0m"
echo
echo -e "\033[34m1.DC云一键破康流控\033[0m"
echo
echo -e "\033[34m2.DC云一键破猫流控\033[0m"
echo
echo -e "\033[34m3.DC云SSR流控管理系统\033[0m"
echo
echo -e "\033[34m4.骚逼汪一键后端云\033[0m"
echo
echo -e "\033[34m5.康师傅一键后端云\033[0m"
echo
echo -e "\033[34m6.吾爱一键后端云\033[0m"
echo
echo -e "\033[34m7.一键锐速安装\033[0m"
echo
echo -n "输入选项: " 
read mode
if [ -z $mode ] 
then
echo -e "安装类型：\033[32m流控脚本\033[0m" ; 
wget  https://raw.githubusercontent.com/joe1280/DC/master/Panel.sh >/dev/null 2>&1
bash Panel.sh 
fi

if [[ $mode == "1" ]]     
then     
echo -e "安装类型：\033[32mDC云破康一键流控\033[0m" ;
wget https://raw.githubusercontent.com/joe1280/DC/master/dc123 >/dev/null 2>&1 
bash dc123  
fi

if [[ $mode == "2" ]]     
then
echo -e "安装类型：\033[32mDC云破猫一键流控\033[0m" ;  
wget  https://raw.githubusercontent.com/joe1280/DC/master/dcmao >/dev/null 2>&1
bash dcmao
fi

if [[ $mode == "3" ]]     
then
echo -e "安装类型：\033[32mDC云SSR流控管理系统\033[0m" ;  
wget  https://raw.githubusercontent.com/joe1280/DC/master/ssrdc >/dev/null 2>&1
bash ssrdc
fi

if [[ $mode == "4" ]]     
then
echo -e "安装类型：\033[32m骚逼汪一键后端云\033[0m" ;  
wget  https://raw.githubusercontent.com/joe1280/DC/master/sbwdc >/dev/null 2>&1
bash sbwdc
fi

if [[ $mode == "5" ]]     
then     
echo -e "安装类型：\033[32m康师傅一键后端云\033[0m"; 
wget  https://raw.githubusercontent.com/joe1280/DC/master/ksfdc >/dev/null 2>&1
bash ksfdc
fi

if [[ $mode == "6" ]]     
then     
echo -e "安装类型：\033[32m吾爱一键后端云\033[0m"; 
wget  https://raw.githubusercontent.com/joe1280/DC/master/wadc >/dev/null 2>&1
bash wadc
fi

if [[ $mode == "7" ]]
then
echo -e "安装类型：\033[32m一键锐速安装\033[0m" ; 
wget  https://raw.githubusercontent.com/joe1280/DC/master/serverSpeeder1 >/dev/null 2>&1
bash serverSpeeder1
fi
fi
fi
rm -- "$0"
exit 0;
