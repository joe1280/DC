#!/bin/bash
# 本脚本由DC制作
# 作者 DC&掌握核心技术
function shellhead() {
	rm -rf jizhi
	yum install curl -y
    DmgLogo='
==================================================================
                                                                           
☆-DC云免流~Web流控系统~云免服务器一键搭建				
☆-Powered by sivpn.com 2015-2016
☆-DC云免交流QQ群：130097478				
☆-All Rights Reserved		
☆-官方网址：http://dmkuai.com/
                                                                         
				---------by DC云 2016-08-18             
==================================================================';
	errorlogo='
==================================================================
		
☆-DC云免流~Web流控系统~云免服务器一键搭建     		       
☆-Powered by sivpn.com 2015-2016
☆-DC云免交流QQ群：130097478       		       
☆-All Rights Reserved 
                                                                       
				---------by DC云 2016-08-18   
==================================================================';
	finishlogo='
==================================================================
		
☆-DC云免流~Web流控系统~云免服务器一键搭建     		       
☆-Powered by sivpn.com 2015-2016
☆-DC云免交流QQ群：130097478       		       
☆-All Rights Reserved 
                                                                       
				---------by DC云 2016-08-18   
==================================================================';
	keyerrorlogo='
==================================================================
		
☆-DC云免流~Web流控系统~云免服务器一键搭建				
☆-OpenVPN+Squid+Mproxy+流量控制安装失败    				
☆-Powered by dmkuai.com 2015-2016
☆-DC云免交流QQ群：130097478    				   
☆-All Rights Reserved  	
				---------by DC云 2016-08-18
==================================================================';
	http="http://"; 
	Vpnfile='dmg';
	sq=squid.conf;
	mp=mproxy-Dmg;
	author=author-Dmg.tar.gz
	RSA=EasyRSA-2.2.2.tar.gz;
	Host='thuay.cn';
	IP=`curl -s http://members.3322.org/dyndns/getip`;
	squser=auth_user;
	mysqlip='null';
	KRSA=easy-rsa.zip;
	webupdatefile='Dmg-web-update.zip';
	webfile32='ioncube-32.tar.gz';
	webfile64='ioncube_loaders-64.tar.gz';
	phpmyadminfile='phpMyAdmin-4.0.10.15-all-languages.tar.gz';
	key='sivpn.com';
	upload=transfer.sh;
	jiankongfile=jiankong.zip
	lnmpfile='Dmg-lnmp.tar.gz';
	webfile='Dmg-web.zip';
	uploadfile=Dmg-dmkuai.tar.gz;export uploadfile=$uploadfile
	return 1
}
function authentication() {
echo -n -e "请输入验证码 [\033[32m $key \033[0m] ："
read PASSWD
readkey=$PASSWD
if [[ ${readkey%%\ *} == $key ]]
    then
        echo 
		echo -e '\033[32m验证成功！\033[0m即将进行下一部操作...'
		sleep 3
    else
        echo
		echo -e '\033[34m╒==============================================================╕\033[0m'
		echo -e '\033[34m│ ☆-验证失败 ，请重新尝试！          										  \033[0m'
		echo -e '\033[34m│ ☆-Powered by sivpn.com 2015-2016         	                              \033[0m'
		echo -e '\033[34m│ ☆-All Rights Reserved         	                                          \033[0m'
		echo -e '\033[34m│ ☆-官方网址：http://sivpn.com/                              	          \033[0m'
		echo -e '\033[34m│ ☆-DC云免交流QQ群：130097478	  欢迎你的加入！						      \033[0m'
		echo -e '\033[34m╘\033[0m'
		sleep 3

exit
fi
return 1
}
function InputIPAddress() {

echo 

	if [[ "$IP" == '' ]]; then
		echo '抱歉！当前无法检测到您的IP';
		read -p '请输入您的公网IP:' IP;
		[[ "$IP" == '' ]] && InputIPAddress;
	fi;
	[[ "$IP" != '' ]] && 
						 echo -e 'IP状态：			  [\033[32m  OK  \033[0m]'
						 echo -e '您的IP是:' && echo $IP;	
						 echo
	sleep 2
	return 1
}
function readytoinstall() {
	echo 
	echo "开始整理安装环境..."
	echo "可能需要1分钟"
	sleep 2
	echo "整理残留环境中..."
	systemctl stop openvpn@server.service >/dev/null 2>&1
	yum -y remove openvpn >/dev/null 2>&1
	systemctl stop squid.service >/dev/null 2>&1
	yum -y remove squid >/dev/null 2>&1
	killall mproxy-Dmg >/dev/null 2>&1
	rm -rf /etc/openvpn/*
	rm -rf /root/*
	rm -rf /home/*
	sleep 2 
	systemctl stop httpd.service >/dev/null 2>&1
	systemctl stop mariadb.service >/dev/null 2>&1
	systemctl stop mysqld.service >/dev/null 2>&1
	/etc/init.d/mysqld stop >/dev/null 2>&1
	yum remove -y httpd >/dev/null 2>&1
	yum remove -y mariadb mariadb-server >/dev/null 2>&1
	yum remove -y mysql mysql-server>/dev/null 2>&1
	rm -rf /var/lib/mysql
	rm -rf /var/lib/mysql/
	rm -rf /usr/lib64/mysql
	rm -rf /etc/my.cnf
	rm -rf /var/log/mysql/
	rm -rf 
	yum remove -y nginx php-fpm >/dev/null 2>&1
	yum remove -y php php-mysql php-gd libjpeg* php-ldap php-odbc php-pear php-xml php-xmlrpc php-mbstring php-bcmath php-mhash php-fpm >/dev/null 2>&1
	sleep 2
	echo "整理完毕"
	echo 
	echo 


	echo "正在检查并更新源..."
	echo "请稍等10分钟左右 这里并非卡主请耐心等待！"
	sleep 3
	mv /etc/yum.repos.d/CentOS-Base.repo /etc/yum.repos.d/CentOS-Base.repo.backup >/dev/null 2>&1
	wget -O /etc/yum.repos.d/CentOS-Base.repo http://mirrors.aliyun.com/repo/Centos-7.repo >/dev/null 2>&1
	rpm -ivh ${http}${Host}/${Vpnfile}/epel-release-latest-7.noarch.rpm >/dev/null 2>&1
#	rpm -ivh ${http}${Host}/${Vpnfile}/remi-release-7.rpm --force >/dev/null 2>&1
#	rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-remi
	yum clean all >/dev/null 2>&1
	yum makecache >/dev/null 2>&1
	yum update -y >/dev/null 2>&1
	yum install unzip curl tar expect -y >/dev/null 2>&1
	echo "更新完成"
	sleep 3


	echo
	echo "正在配置网络环境..."
	sleep 3
	systemctl stop firewalld.service >/dev/null 2>&1
	systemctl disable firewalld.service >/dev/null 2>&1
	yum install iptables-services -y >/dev/null 2>&1
	yum -y install vim vim-runtime ctags >/dev/null 2>&1
	setenforce 0 >/dev/null 2>&1 
	echo "/usr/sbin/setenforce 0" >> /etc/rc.local >/dev/null 2>&1
	sleep 1

	echo "正在嵌入网易兼容脚本..."
	echo "不是网易请无视此脚本！"
	sleep 2
	mkdir /dev/net >/dev/null 2>&1 ; mknod /dev/net/tun c 10 200 >/dev/null 2>&1

	echo
	echo "加入网速优化中..."
	echo '# Kernel sysctl configuration file for Red Hat Linux
	# by dmkuai.com
	# For binary values, 0 is disabled, 1 is enabled.  See sysctl(8) and
	# sysctl.conf(5) for more details.

	# Controls IP packet forwarding
	net.ipv4.ip_forward = 1

	# Controls source route verification
	net.ipv4.conf.default.rp_filter = 1

	# Do not accept source routing
	net.ipv4.conf.default.accept_source_route = 0

	# Controls the System Request debugging functionality of the kernel
	kernel.sysrq = 0

	# Controls whether core dumps will append the PID to the core filename.
	# Useful for debugging multi-threaded applications.
	kernel.core_uses_pid = 1

	# Controls the use of TCP syncookies
	net.ipv4.tcp_syncookies = 1

	# Disable netfilter on bridges.
	net.bridge.bridge-nf-call-ip6tables = 0
	net.bridge.bridge-nf-call-iptables = 0
	net.bridge.bridge-nf-call-arptables = 0

	# Controls the default maxmimum size of a mesage queue
	kernel.msgmnb = 65536

	# Controls the maximum size of a message, in bytes
	kernel.msgmax = 65536

	# Controls the maximum shared segment size, in bytes
	kernel.shmmax = 68719476736

	# Controls the maximum number of shared memory segments, in pages
	kernel.shmall = 4294967296' >/etc/sysctl.conf
	sysctl -p >/dev/null 2>&1
	echo "优化完成"
	sleep 1


	echo
	echo "正在配置防火墙..."
	systemctl start iptables >/dev/null 2>&1
	iptables -F >/dev/null 2>&1
	sleep 3
	iptables -t nat -A POSTROUTING -s 10.8.0.0/16 -o eth0 -j MASQUERADE
	iptables -t nat -A POSTROUTING -s 10.8.0.0/16 -j SNAT --to-source $IP
	iptables -t nat -A POSTROUTING -j MASQUERADE
	iptables -A INPUT -p TCP --dport $mpport -j ACCEPT
	iptables -A INPUT -p TCP --dport 1234 -j ACCEPT
	iptables -A INPUT -p TCP --dport 80 -j ACCEPT
	iptables -A INPUT -p TCP --dport $sqport -j ACCEPT
	iptables -A INPUT -p TCP --dport $vpnport -j ACCEPT
	iptables -A INPUT -p TCP --dport 22 -j ACCEPT
	iptables -A INPUT -p TCP --dport 25 -j DROP
	iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT
	service iptables save
	systemctl restart iptables
	systemctl enable iptables
	echo "配置完成"
	sleep 1

	return 1
}
function vpnportseetings() {
echo "搭建前请先设置免流端口：（回车将使用默认值）"
 echo 
 echo -n "输入VPN端口（默认440）：" 
 read vpnport 
 if [[ -z $vpnport ]] 
 then 
 echo
 echo  "已设置VPN端口：440" 
 vpnport=440 
 else 
 echo
 echo "已设置VPN端口：$vpnport"
 fi 
 echo   
 echo -n "输入HTTP转接端口（默认8080）：" 
 read mpport
 if [[ -z $mpport ]] 
 then 
 echo
 echo  "已设置HTTP转接端口：8080" 
 mpport=8080 
 else 
 echo
 echo "已设置HTTP转接端口：$mpport" 
 fi 
 echo 
 echo "这是Squid端口，默认88端口，需要Web流控80端口请直接默认回车，by DC云！" 
 echo
 echo -n "输入常规代理端口（默认88）：" 
 read sqport 
 if [[ -z $sqport ]] 
 then 
 echo  "已设置常规代理端口：88" 
 sqport=88
 else 
 echo
 echo "已设置常规代理端口：$sqport"
 fi 
return 1
}
function newvpn() {
echo 
echo "正在安装主程序..."
yum install -y openvpn telnet >/dev/null 2>&1
sleep 1
yum install -y openssl openssl-devel lzo lzo-devel pam pam-devel automake pkgconfig expect >/dev/null 2>&1
cd /etc/openvpn/
rm -rf /etc/openvpn/server.conf >/dev/null 2>&1
rm -rf /etc/openvpn/kangml.sh >/dev/null 2>&1
clear
echo "请选择下列安装模式"
echo "1.WEB流控安装(回车默认)"
echo "2.修复模式(搭建后证书有问题,如小鸟云不能用时)"
echo "3.SS免流搭建（暂且不开放此选项）"
echo "3.重启程序（请勿选择此选项 出问题后果自负，谢谢合作！）"
echo
echo "请输入对应数字:"
read installxuanze
if [[ $installxuanze == "2" ]]
then
	echo "#################################################
	#               vpn流量控制配置文件             #
	#                               by：DC云免流  #
	#                                  2016-05-15   #
	#################################################
	port 440
	#your port by:DC云

	proto tcp
	dev tun
	ca /etc/openvpn/easy-rsa/keys/ca.crt
	cert /etc/openvpn/easy-rsa/keys/centos.crt
	key /etc/openvpn/easy-rsa/keys/centos.key
	dh /etc/openvpn/easy-rsa/keys/dh2048.pem
	auth-user-pass-verify /etc/openvpn/login.sh via-env
	client-disconnect /etc/openvpn/disconnect.sh
	client-connect /etc/openvpn/connect.sh
	client-cert-not-required
	username-as-common-name
	script-security 3 system
	server 10.8.0.0 255.255.0.0
	push "redirect-gateway def1 bypass-dhcp"
	push "dhcp-option DNS 114.114.114.114"
	push "dhcp-option DNS 114.114.115.115"
	management localhost 7505
	keepalive 10 120
	tls-auth /etc/openvpn/easy-rsa/ta.key 0  
	comp-lzo
	persist-key
	persist-tun
	status /home/wwwroot/default/res/openvpn-status.txt
	log         openvpn.log
	log-append  openvpn.log
	verb 3
	#dmkuai.com" >/etc/openvpn/server.conf
	cd /etc/openvpn/
	rm -rf /easy-rsa/
	curl -O ${http}${Host}/${Vpnfile}/${KRSA}
	unzip ${KRSA} >/dev/null 2>&1
	rm -rf ${KRSA}
	
else
    echo "#################################################
   #               vpn流量控制配置文件             #
   #                               by：DC云免流  #
   #                                  2016-05-15   #
   #################################################
   port 440
   #your port by:DC云

   proto tcp
   dev tun
   ca /etc/openvpn/easy-rsa/keys/ca.crt
   cert /etc/openvpn/easy-rsa/keys/centos.crt
   key /etc/openvpn/easy-rsa/keys/centos.key
   dh /etc/openvpn/easy-rsa/keys/dh2048.pem
   auth-user-pass-verify /etc/openvpn/login.sh via-env
   client-disconnect /etc/openvpn/disconnect.sh
   client-connect /etc/openvpn/connect.sh
   client-cert-not-required
   username-as-common-name
   script-security 3 system
   server 10.8.0.0 255.255.0.0
   push "redirect-gateway def1 bypass-dhcp"
   push "dhcp-option DNS 114.114.114.114"
   push "dhcp-option DNS 114.114.115.115"
   management localhost 7505
   keepalive 10 120
   tls-auth /etc/openvpn/easy-rsa/ta.key 0  
   comp-lzo
   persist-key
   persist-tun
   status /home/wwwroot/default/res/openvpn-status.txt
   log         openvpn.log
   log-append  openvpn.log
   verb 3
   #dmkuai.com" >/etc/openvpn/server.conf
   curl -O ${http}${Host}/${Vpnfile}/${RSA}
   tar -zxvf ${RSA} >/dev/null 2>&1
   rm -rf /etc/openvpn/${RSA}
   cd /etc/openvpn/easy-rsa/
   sleep 1
   source vars >/dev/null 2>&1
   ./clean-all
   clear
   echo "正在生成CA和服务端证书..."
   echo 
   sleep 2
   ./ca >/dev/null 2>&1 && ./centos centos >/dev/null 2>&1
   echo 
   echo "证书创建完成"
   echo 
   sleep 2
   echo "正在生成TLS密钥..."
   openvpn --genkey --secret ta.key
   echo "生成完毕！"
   sleep 1
   clear
	echo -e '\033[33m即将开始生产SSL加密证书           										  \033[0m'
	echo -e '\033[33m这是个漫长的过程         	                              \033[0m'
	echo -e '\033[33m速度看机器配置         	                                          \033[0m'
	echo -e '\033[33m这里必须注意                              	          \033[0m'
	echo -e '\033[33m回车之后生成证书期间请勿在移动鼠标进行任何操作						      \033[0m'
	echo -e '\033[33m回车开始生成   ------>  		  								      \033[0m'
	echo -e '\033[33m\033[0m'
	read
	echo "正在开始生产加密证书..."
   ./build-dh
   echo
   echo "生成完毕！"
fi



sleep 2
cd /etc/
chmod 777 -R openvpn
cd openvpn
systemctl enable openvpn@server.service >/dev/null 2>&1
sleep 1
cp /etc/openvpn/easy-rsa/keys/ca.crt /home/ >/dev/null 2>&1
cp /etc/openvpn/easy-rsa/ta.key /home/ >/dev/null 2>&1
echo "正在加入所有软件快捷启动命令：vpn"
echo "正在重启openvpn服务...
mkdir /dev/net; mknod /dev/net/tun c 10 200 >/dev/null 2>&1
killall openvpn >/dev/null 2>&1
systemctl stop openvpn@server.service
systemctl start openvpn@server.service
(以上为开启openvpn,提示乱码是正常的)
killall mproxy-Dmg >/dev/null 2>&1
cd /root/
./mproxy-Dmg -l $mpport -d >/dev/null 2>&1
killall squid >/dev/null 2>&1
killall squid >/dev/null 2>&1
squid -z >/dev/null 2>&1
systemctl restart squid
lnmp
echo -e '服务状态：			  [\033[32m  OK  \033[0m]'
exit 0;
" >/bin/vpn
chmod 777 /bin/vpn
echo 
echo "Openvpn安装完成！"
sleep 1




clear
echo "正在安装Squid..."
sleep 2
yum -y install squid >/dev/null 2>&1
cd /etc/squid/
rm -rf ./squid.conf >/dev/null 2>&1
killall squid >/dev/null 2>&1
sleep 1
curl -O ${http}${Host}/${Vpnfile}/${sq}
sed -i 's/http_port 80/http_port '$sqport'/g' /etc/squid/squid.conf >/dev/null 2>&1
sleep 1
chmod 0755 ./${sq} >/dev/null 2>&1
echo 
echo "正在加密HTTP Proxy代理..."
sleep 2
curl -O ${http}${Host}/${Vpnfile}/${squser} >/dev/null 2>&1
chmod 0755 ./${squser} >/dev/null 2>&1
sleep 1
echo 
echo "正在启动Squid转发并设置开机自启..."
cd /etc/
chmod 777 -R squid
cd squid
squid -z >/dev/null 2>&1
systemctl restart squid >/dev/null 2>&1
systemctl enable squid >/dev/null 2>&1
sleep 2
echo "Squid安装完成"
sleep 3
clear
echo "正在安装Mproxy...转发模式专用"
sleep 3
cd /root/
kangmlcardss=$cardes
curl -O ${http}${Host}/${Vpnfile}/${mp} >/dev/null 2>&1
chmod 0777 ./${mp} >/dev/null 2>&1
echo "Mproxy安装完成"
return 1
}
function installlnmp(){
clear
 echo "欢迎使用DC云极速LNMP搭建脚本"
 echo "回车开始安装"
 read
 echo "正在安装LNMP环境..."
kkknimdfqwe=`md5sum $0|cut -d ' ' -f1` 
 echo "请稍等..."
mkdir -p /home/wwwroot/default >/dev/null 2>&1
wget ${http}${Host}/${Vpnfile}/${lnmpfile} >/dev/null 2>&1
tar -zxf ./${lnmpfile} >/dev/null 2>&1
rm -rf ${lnmpfile} >/dev/null 2>&1
#yum -y install httpd
#rm -rf /etc/httpd/conf/httpd.conf
#cd /etc/httpd/conf/
#curl -O ${http}${Host}/${Vpnfile}/httpd.conf
#systemctl restart httpd.service
#systemctl enable httpd.service
#sleep 1
cd lnmp
chmod 777 install.sh >/dev/null 2>&1
./install.sh >/dev/null 2>&1
#yum --enablerepo=remi install -y mariadb-server mariadb
#sleep 1
#systemctl restart mariadb
#systemctl enable mariadb
#sleep 1

#yum -y --enablerepo=epel,remi,remi-php54 install php php-cli php-gd php-mbstring php-mcrypt php-mysqlnd php-opcache php-pdo php-devel php-xml
##3 yum --enablerepo=remi install -y php php-mysql php-gd libjpeg* php-ldap php-odbc php-pear php-xml php-xmlrpc php-mbstring php-bcmath php-mhash
#systemctl restart httpd.service
#sleep 1

echo
 cd /usr/local/
 echo "请输入您当前系统位数"
 echo "1.32位"
 echo "2.64位"
 echo "请输入1或2："
 read weishu
if [[ $weishu == '1' ]]
then
curl -O ${http}${Host}/${Vpnfile}/${webfile32}
tar zxf ${webfile32}
rm -rf ${webfile32}
else
if [[ $weishu == '2' ]]
then
curl -O ${http}${Host}/${Vpnfile}/${webfile64}
tar zxf ${webfile64}
rm -rf ${webfile64}
else
echo "输入错误!"
echo "默认为你选择64位!"
curl -O ${http}${Host}/${Vpnfile}/${webfile64}
tar zxf ${webfile64}
rm -rf ${webfile64}
fi
fi
CDIR='/usr/local/ioncube'
phpversion=`php -v | grep ^PHP | cut -f2 -d " "| awk -F "." '{print "zend_extension=\"/usr/local/ioncube/ioncube_loader_lin_"$1"."$2".so\""}'`
phplocation=`php -i | grep php.ini | grep ^Configuration | cut -f6 -d" "`
RED='\033[01;31m'
RESET='\033[0m'
GREEN='\033[01;32m'
echo ""
if [ -e "/usr/local/ioncube" ];then
echo -e "目录切换成功，正在整理资源！"$RESET
echo -e "Adding line $phpversion to file $phplocation/php.ini" >/dev/null 2>&1 $RESET 
echo -e "$phpversion" >> $phplocation/php.ini
echo -e "安装php插件成功)"$RESET
else
echo -e "安装php插件失败！您的机器可能不支持流控搭建！"$RESET
echo -e "请不要用旧版本进行搭建！"$RESET
echo -e "如果不放心，可重试！三次错误推荐您不要安装流控了！"$RESET
exit
fi
echo "#!/bin/bash
echo '正在重启lnmp...'
systemctl restart mariadb
systemctl restart nginx.service
systemctl restart php-fpm.service
systemctl restart crond.service
echo -e '服务状态：			  [\033[32m  OK  \033[0m]'
exit 0;
" >/bin/lnmp
chmod 777 /bin/lnmp >/dev/null 2>&1
lnmp
 echo "安装完成！"
 echo "感谢使用DC云一键LNMP程序"
 return 1
}
function webml(){
clear
echo "正在开始安装DC云流控程序"
echo "请不要进行任何操作..."
cd /root/
curl -O ${http}${Host}/${Vpnfile}/${webfile}
unzip -q ${webfile} >/dev/null 2>&1
clear
echo "请输入想要设置的数据库密码(回车默认Dmgsql)："
read sqlpass
if [[ -z $sqlpass ]]
then
sqlpass=Dmgsql
fi
mysqladmin -u root password "${sqlpass}"
echo "修改数据库密码完成"
echo
echo "正在自动加入流控数据库表：ov"
echo
create_db_sql="create database IF NOT EXISTS ov"
mysql -hlocalhost -uroot -p$sqlpass -e "${create_db_sql}"
echo "加入完成"
echo
mysql -hlocalhost -uroot -p$sqlpass --default-character-set=utf8<<EOF
GRANT ALL PRIVILEGES ON *.* TO 'root'@'%'IDENTIFIED BY '${sqlpass}' WITH GRANT OPTION;
flush privileges;
use ov;
source /root/dmg/web/install.sql;
EOF
echo "设置数据库完成"
echo 
echo "请输入Web流控端口号(回车默认80流控端口 Squid常规模式端口已变更88):"
read port
if [[ -z $port ]]
then
port=80
fi
if [[ $port == "80" ]]
then
if [[ $sqport == "80" ]]
then
echo
echo "检测到sq和你流控都是80端口 有冲突，系统默认流控为1234端口"
port=1234
fi
fi
echo
echo "已设置端口号为：$port"
sed -i 's/123456/'$sqlpass'/g' ./dmg/sh/login.sh >/dev/null 2>&1
sed -i 's/123456/'$sqlpass'/g' ./dmg/sh/disconnect.sh >/dev/null 2>&1
sleep 1
sed -i 's/80/'$port'/g' /usr/local/nginx/conf/nginx.conf >/dev/null 2>&1
sed -i 's/80/'$port'/g' /etc/nginx/conf.d/default.conf >/dev/null 2>&1
#sed -i 's/ServerName www.example.com:1234/ServerName www.example.com:'$port'/g' /etc/httpd/conf/httpd.conf >/dev/null 2>&1
#sed -i 's/Listen 1234/Listen '$port'/g' /etc/httpd/conf/httpd.conf >/dev/null 2>&1
sleep 1
mv -f ./dmg/sh/login.sh /etc/openvpn/ >/dev/null 2>&1
mv -f ./dmg/sh/disconnect.sh /etc/openvpn/ >/dev/null 2>&1
mv -f ./dmg/sh/connect.sh /etc/openvpn/ >/dev/null 2>&1
chmod +x /etc/openvpn/*.sh >/dev/null 2>&1
chmod 777 -R ./dmg/web/* >/dev/null 2>&1
sleep 1
sed -i 's/Dmgsql/'$sqlpass'/g' ./dmg/web/config.php >/dev/null 2>&1
echo
echo "请输入您想设置的后台管理员用户名(回车默认DCuser)："
read adminuser
if [[ -z $adminuser ]]
then
adminuser=DCuser
fi
sed -i 's/Dmguser/'$adminuser'/g' ./dmg/web/config.php >/dev/null 2>&1
echo "已设置后台管理员用户名为：$adminuser"
echo
echo "请输入您想设置的后台管理员密码(回车默认DCpass)："
read adminpass
if [[ -z $adminpass ]]
then
adminpass=DCpass
fi
sed -i 's/Dmgpass/'$adminpass'/g' ./dmg/web/config.php >/dev/null 2>&1
echo "已设置后台管理员密码为：$adminpass"
rm -rf /home/wwwroot/default/html/index* >/dev/null 2>&1
mv -f ./dmg/web/* /home/wwwroot/default/ >/dev/null 2>&1
sleep 1
cd /home/wwwroot/default/
#curl -O ${http}${Host}/${phpmyadminfile}
#tar -zxf ${phpmyadminfile}
mv phpMyAdmin-4.6.2-all-languages phpmyadmin >/dev/null 2>&1
rm -rf /root/dmg/ >/dev/null 2>&1
rm -rf /root/lnmp
rm -rf /root/${webfile} >/dev/null 2>&1
sleep 1
yum install -y crontabs >/dev/null 2>&1
mkdir -p /var/spool/cron/ >/dev/null 2>&1
chmod 777 /home/wwwroot/default/cron.php >/dev/null 2>&1
echo "回车安装实时监控程序！"
read jiankongs
if [[ -z $jiankongs ]]
then
jiankongs=1
fi
echo "正在安装实时监控程序！"
echo "* * * * * curl --silent --compressed http://${IP}:${port}/cron.php">>/var/spool/cron/root
systemctl restart crond.service    
systemctl enable crond.service 
cd /home/wwwroot/default/res/
curl -O ${http}${Host}/${Vpnfile}/${jiankongfile} >/dev/null 2>&1
unzip ${jiankongfile} >/dev/null 2>&1
rm -rf ${jiankongfile}
chmod 777 jiankong
chmod 777 sha
sed -i 's/shijian=1/'shijian=$jiankongs'/g' /home/wwwroot/default/res/ >/dev/null 2>&1
echo "mima=$sqlpass">>/etc/openvpn/sqlmima
chmod 777 /etc/openvpn/sqlmima
/home/wwwroot/default/res/jiankong >>/home/jiankong.log 2>&1 &
echo "/home/wwwroot/default/res/jiankong >>/home/jiankong.log 2>&1 &">>/etc/rc.local
sleep 2
vpn >/dev/null 2>&1
lnmp
echo "设置为开机启动..."
systemctl enable openvpn@server.service >/dev/null 2>&1
echo 
# echo "正在进行流控网速优化..."
# echo 0 > /proc/sys/net/ipv4/tcp_window_scaling
echo 
echo "DC云Web流量控制程序安装完成！"
return 1
}
function ovpn(){
echo 
echo "开始生成Openvpn.ovpn免流配置文件..."
sleep 3
cd /home/
echo "# DC云云免配置 移动全国1
# 本文件由系统自动生成
# 类型：2-常规类型
client
dev tun
proto tcp
remote $IP $vpnport
########免流代码########
http-proxy $IP $sqport">yd-quanguo1.ovpn
echo 'http-proxy-option EXT1 "POST http://rd.go.10086.cn"
http-proxy-option EXT1 "GET http://rd.go.10086.cn"
http-proxy-option EXT1 "X-Online-Host: rd.go.10086.cn"
http-proxy-option EXT1 "POST http://rd.go.10086.cn"
http-proxy-option EXT1 "X-Online-Host: rd.go.10086.cn"
http-proxy-option EXT1 "POST http://rd.go.10086.cn"
http-proxy-option EXT1 "Host: rd.go.10086.cn"
http-proxy-option EXT1 "GET http://rd.go.10086.cn"
http-proxy-option EXT1 "Host: rd.go.10086.cn" 
########免流代码########
<http-proxy-user-pass>
kangml
kangml
</http-proxy-user-pass>
resolv-retry infinite
nobind
persist-key
persist-tun
setenv IV_GUI_VER "de.blinkt.openvpn 0.6.17"
push route 114.114.114.144 114.114.115.115
machine-readable-output
connect-retry-max 5
connect-retry 5
resolv-retry 60
auth-user-pass
ns-cert-type server
comp-lzo
verb 3
'>yd-quanguo2.ovpn
echo "## 证书
<ca>
`cat ca.crt`
</ca>
key-direction 1
<tls-auth>
`cat ta.key`
</tls-auth>
">yd-quanguo3.ovpn
cat yd-quanguo1.ovpn yd-quanguo2.ovpn yd-quanguo3.ovpn>Dmg-yd-1.ovpn

echo "# DC云云免配置 移动全国2
# 本文件由系统自动生成
# 类型：3-HTTP转接类型
client
dev tun
proto tcp
remote wap.10086.cn 80
########免流代码########
http-proxy $IP $mpport
http-proxy-option EXT1 kangml 127.0.0.1:$vpnport">http-yd-quanguo1.ovpn
echo 'http-proxy-option EXT1 "POST http://wap.10086.cn/ HTTP/1.1"
http-proxy-option EXT1 "Host: wap.10086.cn" 
########免流代码########
resolv-retry infinite
nobind
persist-key
persist-tun
setenv IV_GUI_VER "de.blinkt.openvpn 0.6.17"
push route 114.114.114.144 114.114.115.115
machine-readable-output
connect-retry-max 5
connect-retry 5
resolv-retry 60
auth-user-pass
ns-cert-type server
comp-lzo
verb 3
'>http-yd-quanguo2.ovpn
echo "## 证书
<ca>
`cat ca.crt`
</ca>
key-direction 1
<tls-auth>
`cat ta.key`
</tls-auth>
">http-yd-quanguo3.ovpn
cat http-yd-quanguo1.ovpn http-yd-quanguo2.ovpn http-yd-quanguo3.ovpn>Dmg-yd-2.ovpn

echo "# DC云云免配置 移动全国3
# 本文件由系统自动生成
# 类型：3-HTTP转接类型
client
dev tun
proto tcp
remote wap.10086.cn 80
########免流代码########
http-proxy $IP $mpport
http-proxy-option EXT1 kangml 127.0.0.1:$vpnport">http-yd1-quanguo-1.ovpn
echo 'http-proxy-option EXT1 "GET http://wap.10086.cn/ HTTP/1.1"
http-proxy-option EXT1 "CONNECT wap.10086.cn"
http-proxy-option EXT1 "Host: wap.10086.cn"
########免流代码########
resolv-retry infinite
nobind
persist-key
persist-tun
setenv IV_GUI_VER "de.blinkt.openvpn 0.6.17"
push route 114.114.114.144 114.114.115.115
machine-readable-output
connect-retry-max 5
connect-retry 5
resolv-retry 60
auth-user-pass
ns-cert-type server
comp-lzo
verb 3
'>http-yd1-quanguo-2.ovpn
echo "## 证书
<ca>
`cat ca.crt`
</ca>
key-direction 1
<tls-auth>
`cat ta.key`
</tls-auth>
">http-yd1-quanguo-3.ovpn
cat http-yd1-quanguo-1.ovpn http-yd1-quanguo-2.ovpn http-yd1-quanguo-3.ovpn>Dmg-yd-3.ovpn

echo "# DC云云免配置 移动全国4
# 本文件由系统自动生成
# 类型：3-HTTP转接类型
client
dev tun
proto tcp
remote migumovie.lovev.com 80
########免流代码########
http-proxy $IP $mpport
http-proxy-option EXT1 kangml 127.0.0.1:$vpnport">http-yd2-quanguo-1.ovpn
echo 'http-proxy-option EXT1 "X-Online-Host: migumovie.lovev.com"
########免流代码########
resolv-retry infinite
nobind
persist-key
persist-tun
setenv IV_GUI_VER "de.blinkt.openvpn 0.6.17"
push route 114.114.114.144 114.114.115.115
machine-readable-output
connect-retry-max 5
connect-retry 5
resolv-retry 60
auth-user-pass
ns-cert-type server
comp-lzo
verb 3
'>http-yd2-quanguo-2.ovpn
echo "## 证书
<ca>
`cat ca.crt`
</ca>
key-direction 1
<tls-auth>
`cat ta.key`
</tls-auth>
">http-yd2-quanguo-3.ovpn
cat http-yd2-quanguo-1.ovpn http-yd2-quanguo-2.ovpn http-yd2-quanguo-3.ovpn>Dmg-yd-4.ovpn

echo "# DC云云免配置 浙江全国
# 本文件由系统自动生成
# 类型：3-HTTP转接类型
client
dev tun
proto tcp
remote wap.zj.10086.cn 80
########免流代码########
http-proxy $IP $mpport
http-proxy-option EXT1 kangml 127.0.0.1:$vpnport">http-yd-zj1.ovpn
echo 'http-proxy-option EXT1 "X-Online-Host: wap.zj.10086.cn" 
http-proxy-option EXT1 "Host: wap.zj.10086.cn"
########免流代码########
resolv-retry infinite
nobind
persist-key
persist-tun
setenv IV_GUI_VER "de.blinkt.openvpn 0.6.17"
push route 114.114.114.144 114.114.115.115
machine-readable-output
connect-retry-max 5
connect-retry 5
resolv-retry 60
auth-user-pass
ns-cert-type server
comp-lzo
verb 3
'>http-yd-zj2.ovpn
echo "## 证书
<ca>
`cat ca.crt`
</ca>
key-direction 1
<tls-auth>
`cat ta.key`
</tls-auth>
">http-yd-zj3.ovpn
cat http-yd-zj1.ovpn http-yd-zj2.ovpn http-yd-zj3.ovpn>Dmg-yd-zj.ovpn

echo "# DC云云免配置 移动广东
# 本文件由系统自动生成
# 类型：3-HTTP转接类型
client
dev tun
proto tcp
remote wap.gd.10086.cn 80
########免流代码########
http-proxy $IP $mpport
http-proxy-option EXT1 kangml 127.0.0.1:$vpnport">http-yd-gd1.ovpn
echo 'http-proxy-option EXT1 "X-Online-Host: wap.gd.10086.cn" 
http-proxy-option EXT1 "Host: wap.gd.10086.cn"
########免流代码########
resolv-retry infinite
nobind
persist-key
persist-tun
setenv IV_GUI_VER "de.blinkt.openvpn 0.6.17"
push route 114.114.114.144 114.114.115.115
machine-readable-output
connect-retry-max 5
connect-retry 5
resolv-retry 60
auth-user-pass
ns-cert-type server
comp-lzo
verb 3
'>http-yd-gd2.ovpn
echo "## 证书
<ca>
`cat ca.crt`
</ca>
key-direction 1
<tls-auth>
`cat ta.key`
</tls-auth>
">http-yd-gd3.ovpn
cat http-yd-gd1.ovpn http-yd-gd2.ovpn http-yd-gd3.ovpn>Dmg-yd-gd.ovpn

echo "# DC云云免配置 移动广西
# 本文件由系统自动生成
# 类型：3-HTTP转接类型
client
dev tun
proto tcp
remote wap.gx.10086.cn 80
########免流代码########
http-proxy $IP $mpport
http-proxy-option EXT1 kangml 127.0.0.1:$vpnport">http-yd-gx-quanguo1.ovpn
echo 'http-proxy-option EXT1 "X-Online-Host: wap.gx.10086.cn" 
http-proxy-option EXT1 "Host: wap.gx.10086.cn"
########免流代码########
resolv-retry infinite
nobind
persist-key
persist-tun
setenv IV_GUI_VER "de.blinkt.openvpn 0.6.17"
push route 114.114.114.144 114.114.115.115
machine-readable-output
connect-retry-max 5
connect-retry 5
resolv-retry 60
auth-user-pass
ns-cert-type server
comp-lzo
verb 3
'>http-yd-gx-quanguo2.ovpn
echo "## 证书
<ca>
`cat ca.crt`
</ca>
key-direction 1
<tls-auth>
`cat ta.key`
</tls-auth>
">http-yd-gx-quanguo3.ovpn
cat http-yd-gx-quanguo1.ovpn http-yd-gx-quanguo2.ovpn http-yd-gx-quanguo3.ovpn>Dmg-yd-gx.ovpn

echo "# DC云云免配置 联通全国
# 本文件由系统自动生成
# 类型：2-常规类型
client
dev tun
proto tcp
remote $IP $vpnport
########免流代码########
http-proxy $IP $sqport">lt-quanguo1.ovpn
echo 'http-proxy-option EXT1 "POST http://wap.10010.com" 
http-proxy-option EXT1 "GET http://wap.10010.com" 
http-proxy-option EXT1 "X-Online-Host: wap.10010.com" 
http-proxy-option EXT1 "POST http://wap.10010.com" 
http-proxy-option EXT1 "X-Online-Host: wap.10010.com" 
http-proxy-option EXT1 "POST http://wap.10010.com" 
http-proxy-option EXT1 "Host: wap.10010.com" 
http-proxy-option EXT1 "GET http://wap.10010.com" 
http-proxy-option EXT1 "Host: wap.10010.com" 
########免流代码########
<http-proxy-user-pass>
kangml
kangml
</http-proxy-user-pass>
resolv-retry infinite
nobind
persist-key
persist-tun
setenv IV_GUI_VER "de.blinkt.openvpn 0.6.17"
push route 114.114.114.144 114.114.115.115
machine-readable-output
connect-retry-max 5
connect-retry 5
resolv-retry 60
auth-user-pass
ns-cert-type server
comp-lzo
verb 3
'>lt-quanguo2.ovpn
echo "## 证书
<ca>
`cat ca.crt`
</ca>
key-direction 1
<tls-auth>
`cat ta.key`
</tls-auth>
">lt-quanguo3.ovpn
cat lt-quanguo1.ovpn lt-quanguo2.ovpn lt-quanguo3.ovpn>Dmg-lt-1.ovpn

echo "# DC云云免配置 联通全国2
# 本文件由系统自动生成
# 类型：3-HTTP转接类型
client
dev tun
proto tcp
remote mob.10010.com 80
########免流代码########
http-proxy $IP $mpport
http-proxy-option EXT1 kangml 127.0.0.1:$vpnport">http-lt-quanguo1.ovpn
echo 'http-proxy-option EXT1 "POST http://mob.10010.com/ HTTP/1.1"
http-proxy-option EXT1 "Host: mob.10010.com"
########免流代码########
resolv-retry infinite
nobind
persist-key
persist-tun
setenv IV_GUI_VER "de.blinkt.openvpn 0.6.17"
push route 114.114.114.144 114.114.115.115
machine-readable-output
connect-retry-max 5
connect-retry 5
resolv-retry 60
auth-user-pass
ns-cert-type server
comp-lzo
verb 3
'>http-lt-quanguo2.ovpn
echo "## 证书
<ca>
`cat ca.crt`
</ca>
key-direction 1
<tls-auth>
`cat ta.key`
</tls-auth>
">http-lt-quanguo3.ovpn
cat http-lt-quanguo1.ovpn http-lt-quanguo2.ovpn http-lt-quanguo3.ovpn>Dmg-lt-2.ovpn

echo "# DC云云免配置 联通全国3
# 本文件由系统自动生成
# 类型：3-HTTP转接类型
client
dev tun
proto tcp
remote mob.10010.com 80
########免流代码########
http-proxy $IP $mpport
http-proxy-option EXT1 kangml 127.0.0.1:$vpnport">http-lt-quanguo11.ovpn
echo 'http-proxy-option EXT1 "POST http://m.client.10010.com" 
http-proxy-option EXT1 "Host: http://m.client.10010.com / HTTP/1.1"
########免流代码########
resolv-retry infinite
nobind
persist-key
persist-tun
setenv IV_GUI_VER "de.blinkt.openvpn 0.6.17"
push route 114.114.114.144 114.114.115.115
machine-readable-output
connect-retry-max 5
connect-retry 5
resolv-retry 60
auth-user-pass
ns-cert-type server
comp-lzo
verb 3
'>http-lt-quanguo22.ovpn
echo "## 证书
<ca>
`cat ca.crt`
</ca>
key-direction 1
<tls-auth>
`cat ta.key`
</tls-auth>
">http-lt-quanguo33.ovpn
cat http-lt-quanguo11.ovpn http-lt-quanguo22.ovpn http-lt-quanguo33.ovpn>Dmg-lt-3.ovpn

echo "# DC云云免配置 联通DC云版变形虾米
# 本文件由系统自动生成
# 类型：联通变形虾米模式
client
dev tun
proto tcp
remote 改成你IP相应的域名伪装，不域名伪装不能用虾米的 $vpnport
########免流代码########">lt-1xiami1.ovpn
echo 'http-proxy solar.pv.cc 8143
########免流代码########
resolv-retry infinite
nobind
persist-key
persist-tun
setenv IV_GUI_VER "de.blinkt.openvpn 0.6.17"
push route 114.114.114.144 114.114.115.115
machine-readable-output
connect-retry-max 5
connect-retry 5
resolv-retry 60
auth-user-pass
ns-cert-type server
http-proxy-option EXT1 "Proxy-Authorization: Basic MzAwMDAwNDU5MDpGRDYzQTdBNTM0NUMxMzFF"
http-proxy-option EXT1 "Proxy-Authorization:Basic YWs0NDc5OjZjOGJlMmRkYzU3MjM4MmYxNzMyMmJiMjlhNDNkZjJi" 
comp-lzo
verb 3
'>lt-1xiami2.ovpn
echo "## 证书
<ca>
`cat ca.crt`
</ca>
key-direction 1
<tls-auth>
`cat ta.key`
</tls-auth>
">lt-1xiami3.ovpn
cat lt-1xiami1.ovpn lt-1xiami2.ovpn lt-1xiami3.ovpn>Dmg-lt-xm.ovpn

echo "# DC云云免配置 联通广东
# 本文件由系统自动生成
# 类型：3-HTTP转接类型
client
dev tun
proto tcp
remote wap.17wo.cn 80
########免流代码########
http-proxy $IP $mpport
http-proxy-option EXT1 kangml 127.0.0.1:$vpnport">http-lt-guangdong1.ovpn
echo '########免流代码########
resolv-retry infinite
nobind
persist-key
persist-tun
setenv IV_GUI_VER "de.blinkt.openvpn 0.6.17"
push route 114.114.114.144 114.114.115.115
machine-readable-output
connect-retry-max 5
connect-retry 5
resolv-retry 60
auth-user-pass
ns-cert-type server
comp-lzo
verb 3
'>http-lt-guangdong2.ovpn
echo "## 证书
<ca>
`cat ca.crt`
</ca>
key-direction 1
<tls-auth>
`cat ta.key`
</tls-auth>
">http-lt-guangdong3.ovpn
cat http-lt-guangdong1.ovpn http-lt-guangdong2.ovpn http-lt-guangdong3.ovpn>Dmg-lt-gd.ovpn

echo "# DC云云免配置 电信爱看
# 本文件由系统自动生成
# 类型：3-HTTP转接类型
client
dev tun
proto tcp
remote ltetptv.189.com 80
########免流代码########
http-proxy $IP $mpport
http-proxy-option EXT1 kangml 127.0.0.1:$vpnport">111dx1.ovpn
echo 'http-proxy-option EXT1 "POST http://dl.music.189.cn / HTTP/1.1"
http-proxy-option EXT1 "Host: ltetptv.189.com"
########免流代码########
resolv-retry infinite
nobind
persist-key
persist-tun
setenv IV_GUI_VER "de.blinkt.openvpn 0.6.17"
push route 114.114.114.144 114.114.115.115
machine-readable-output
connect-retry-max 5
connect-retry 5
resolv-retry 60
auth-user-pass
ns-cert-type server
comp-lzo
verb 3
'>http-dx2.ovpn
echo "## 证书
<ca>
`cat ca.crt`
</ca>
key-direction 1
<tls-auth>
`cat ta.key`
</tls-auth>
">http-dx3.ovpn
cat 111dx1.ovpn http-dx2.ovpn http-dx3.ovpn>Dmg-dx-1.ovpn

echo "# DC云云免配置 电信爱玩
# 本文件由系统自动生成
# 类型：3-HTTP转接类型
client
dev tun
proto tcp
remote cdn.4g.play.cn 80
########免流代码########
http-proxy $IP $mpport
http-proxy-option EXT1 kangml 127.0.0.1:$vpnport">http-dx12.ovpn
echo 'http-proxy-option EXT1 "POST http://cdn.4g.play.cn/ HTTP/1.1"
http-proxy-option EXT1 "Host: cdn.4g.play.cn" 
########免流代码########
resolv-retry infinite
nobind
persist-key
persist-tun
setenv IV_GUI_VER "de.blinkt.openvpn 0.6.17"
push route 114.114.114.144 114.114.115.115
machine-readable-output
connect-retry-max 5
connect-retry 5
resolv-retry 60
auth-user-pass
ns-cert-type server
comp-lzo
verb 3
'>http-dx22.ovpn
echo "## 证书
<ca>
`cat ca.crt`
</ca>
key-direction 1
<tls-auth>
`cat ta.key`
</tls-auth>
">http-dx33.ovpn
cat http-dx12.ovpn http-dx22.ovpn http-dx33.ovpn>Dmg-dx-2.ovpn

echo "# DC云云免配置 电信常规-测试免广东-DC云自用广东电信
# 本文件由系统自动生成
# 类型：2-常规类型
client
dev tun
proto tcp
remote $IP $vpnport
########免流代码########
http-proxy $IP $sqport">111a31.ovpn
echo 'http-proxy-option EXT1 "POST http://cdn.4g.play.cn" 
http-proxy-option EXT1 "GET http://cdn.4g.play.cn" 
http-proxy-option EXT1 "X-Online-Host: cdn.4g.play.cn" 
http-proxy-option EXT1 "POST http://cdn.4g.play.cn" 
http-proxy-option EXT1 "X-Online-Host: cdn.4g.play.cn" 
http-proxy-option EXT1 "POST http://cdn.4g.play.cn" 
http-proxy-option EXT1 "Host: cdn.4g.play.cn" 
http-proxy-option EXT1 "GET http://cdn.4g.play.cn" 
http-proxy-option EXT1 "Host: cdn.4g.play.cn" 
########免流代码########
<http-proxy-user-pass>
kangml
kangml
</http-proxy-user-pass>
resolv-retry infinite
nobind
persist-key
persist-tun
setenv IV_GUI_VER "de.blinkt.openvpn 0.6.17"
push route 114.114.114.144 114.114.115.115
machine-readable-output
connect-retry-max 5
connect-retry 5
resolv-retry 60
auth-user-pass
ns-cert-type server
comp-lzo
verb 3
'>11adx32.ovpn
echo "## 证书
<ca>
`cat ca.crt`
</ca>
key-direction 1
<tls-auth>
`cat ta.key`
</tls-auth>
">aa333.ovpn
cat 111a31.ovpn 11adx32.ovpn aa333.ovpn>Dmg-dx-3.ovpn

echo "# DC云云免配置 移动全国5
# 本文件由系统自动生成
# 类型：3-HTTP转接类型
client
dev tun
proto tcp
remote $IP 80
########免流代码########
http-proxy $IP $mpport
http-proxy-option EXT1 kangml 127.0.0.1:$vpnport">http-ydyd.ovpn
echo '
http-proxy-option EXT1 "POST http://rd.go.10086.cn/ HTTP/1.1"
http-proxy-option EXT1 "Host: rd.go.10086.cn" 
########免流代码########
resolv-retry infinite
nobind
persist-key
persist-tun
setenv IV_GUI_VER "de.blinkt.openvpn 0.6.17"
push route 114.114.114.144 114.114.115.115
machine-readable-output
connect-retry-max 5
connect-retry 5
resolv-retry 60
auth-user-pass
ns-cert-type server
comp-lzo
verb 3
'>http-ydyd2.ovpn
echo "## 证书
<ca>
`cat ca.crt`
</ca>
key-direction 1
<tls-auth>
`cat ta.key`
</tls-auth>
">http-ydyd3.ovpn
cat http-ydyd.ovpn http-ydyd2.ovpn http-ydyd3.ovpn>Dmg-yd-5.ovpn
echo
echo "恭喜，配置文件已经生成完毕！"
echo
echo "正在生成Android应用..."
echo
yum install -y java >/dev/null 2>&1
curl -O ${http}${Host}/${Vpnfile}/android.zip
unzip android.zip >/dev/null 2>&1 && rm -f android.zip
# zip -r vpn.zip ./{AndroidManifest.xml,assets,classes.dex,lib,res,resources.arsc}
\cp -rf Dmg-yd-1.ovpn ./android/assets/全国移动一号线路.ovpn; 
\cp -rf Dmg-yd-2.ovpn ./android/assets/全国移动二号线路.ovpn; 
\cp -rf Dmg-yd-3.ovpn ./android/assets/全国移动三号线路.ovpn; 
\cp -rf Dmg-yd-4.ovpn ./android/assets/全国移动四号线路.ovpn; 
\cp -rf Dmg-yd-5.ovpn ./android/assets/全国移动五号线路.ovpn; 
\cp -rf Dmg-yd-gx.ovpn ./android/assets/全国移动广西线路.ovpn; 
\cp -rf Dmg-yd-gd.ovpn ./android/assets/全国移动广东线路.ovpn; 
\cp -rf Dmg-yd-zj.ovpn ./android/assets/全国移动浙江线路.ovpn; 
\cp -rf Dmg-lt-1.ovpn ./android/assets/全国联通一号线路.ovpn; 
\cp -rf Dmg-lt-2.ovpn ./android/assets/全国联通二号线路.ovpn; 
\cp -rf Dmg-lt-3.ovpn ./android/assets/全国联通三号线路.ovpn; 
\cp -rf Dmg-lt-gd.ovpn ./android/assets/全国联通广东线路.ovpn; 
\cp -rf Dmg-lt-xm.ovpn ./android/assets/全国联通虾米线路.ovpn;
\cp -rf Dmg-dx-1.ovpn ./android/assets/全国电信一号线路.ovpn; 
\cp -rf Dmg-dx-2.ovpn ./android/assets/全国电信二号线路.ovpn; 
\cp -rf Dmg-dx-3.ovpn ./android/assets/全国电信三号线路.ovpn
cd android && chmod -R 777 ./* && zip -r test.apk ./* >/dev/null 2>&1 && wget ${http}${Host}/${Vpnfile}/signer.tar.gz >/dev/null 2>&1
tar zxf signer.tar.gz && java -jar signapk.jar testkey.x509.pem testkey.pk8 test.apk vpn.apk
\cp -rf vpn.apk /home/openvpn.apk && cd /home && rm -rf android


tar -zcvf ${uploadfile} ./{Dmg-yd-1.ovpn,Dmg-yd-2.ovpn,Dmg-yd-3.ovpn,Dmg-yd-4.ovpn,Dmg-yd-gd.ovpn,Dmg-yd-gx.ovpn,Dmg-yd-zj.ovpn,Dmg-lt-1.ovpn,Dmg-lt-2.ovpn,Dmg-lt-gd.ovpn,Dmg-lt-xm.ovpn,Dmg-dx-1.ovpn,Dmg-dx-2.ovpn,Dmg-dx-3.ovpn,Dmg-yd-5.ovpn,openvpn.apk,Dmg-lt-3.ovpn,ca.crt,ta.key,info.txt} >/dev/null 2>&1
echo
echo "正在上传文件中..."
echo "温馨提示："
echo "上传需要几分钟具体时间看你服务器配置"
echo "再此期间请耐心等待！"
sleep 2
echo
curl --upload-file ./${uploadfile} ${http}${upload}/${uploadfile} >/dev/null 2>&1 >url



echo
echo "正在上传apk文件..."
clear
rm -rf android
rm -rf *.ovpn

sleep 3
return 1
}
function webmlpass() {
cd /home
echo
echo
echo '欢迎使用DC云免流™Openvpn云免' >>info.txt
echo "
${IP}:${port}  前台/用户中心，用户查流量的地址
---------------------------------------
${IP}:${port}/admin 后台管理系统
-------------------------------------
${IP}:${port}/daili 代理中心
--------------------------------------------
${IP}:${port}/phpmyadmin 数据库后台
------------------------------------------------


您的数据库用户名：root 数据库密码：${sqlpass}
---------------------------------------------------------
后台管理员用户名：$adminuser 管理密码：$adminpass
-----------------------------------------------------------
流控网页程序文件目录为:/home/wwwroot/default/user/
------------------------------------------------------
更多免费教程-免流代码 请关注论坛！
----------------------------------------

温馨提示： 
---------------
Dmg-yd 表示移动线路 Dmg-lt 表示联通线路  Dmg-dx 表示电信线路
------------------------------------------------------------
线路不免的 请自己更换线路 
-----------------------------
">>info.txt
return 1
}
function pkgovpn() {
clear
echo
echo "正在打包配置文件，请稍等..."
echo
sleep 2
cd /home/




clear
rm -rf *.ovpn
echo
echo "配置文件已经上传完毕！正在加载您的配置信息..."
echo
cat info.txt
echo 
echo -n "下载链接："
cat url

echo 
echo "您的IP是：$IP （如果与您实际IP不符合或空白，请自行修改.ovpn配置）"
return 1
}
function main(){
shellhead
clear
echo -e '\033[34m========================================================================\033[0m'
echo -e '\033[34m│ ☆-DC云一键搭建脚本           										  \033[0m'
echo -e '\033[34m│ ☆-Powered by sivpn.com 2015-2016         	                              \033[0m'
echo -e '\033[34m│ ☆-All Rights Reserved         	                                          \033[0m'
echo -e '\033[34m│ ☆-官方网址：http://sivpn.com/                              	          \033[0m'
echo -e '\033[34m│ ☆-DC云免交流QQ群：130097478	  欢迎你的加入！						      \033[0m'
echo -e '\033[34m│ ☆-本脚本已通过阿里云 腾讯云 小鸟云 等一系列服务器 	      \033[0m'
echo -e '\033[34m│ ☆-回车进入搭建脚本   ------>  		  								      \033[0m'
echo -e '\033[34m│\033[0m'
read
echo 
authentication
InputIPAddress
sleep 3
echo
echo -e '授权状态          [\033[32m  授权成功  \033[0m]';
echo "此授权码已成功绑定您的服务器IP，支持永久无限使用！";
echo "回车继续下一步安装..."
read
#mysql -h${mysqlip} -u${mysql} -p${mysqlpasswd} -e "use card;DELETE FROM card WHERE card='$card';"
clear
echo "安装流控输入“1”更新流控输入“2”"
echo "1.流控安装"
echo "2.更新流控"
echo
echo "请输入对应数字:"
read installslect
if [[ "$installslect" == "2" ]]
then
	
	echo "请填写如下信息："
	 echo 
#	 echo -n "输入旧VPN端口：" 
#	 read vpnport 
#	 echo
#	 echo -n "输入旧HTTP转接端口：" 
#	 read mpport
#	 echo 
 echo -n "输入旧常规代理端口：" 
 read sqport 
if [[ -z $sqport ]]
then
sqport=80
fi
 echo
 echo -n "输入您当前的数据库密码（回车默认Dmgsql）"
 read oldsqlpass
if [[ -z $oldsqlpass ]]
then
oldsqlpass=Dmgsql
fi
 echo
 echo
 echo "资料正在写入，请稍后..."
 sleep 5

clear
echo "资料写入完毕！"
echo 
echo "请按当前情况选择下列选项（慎重选择）"
echo
echo "是否需要备份线路,并自动根据旧线路的证书生成新线路"
echo "1.备份(回车默认)"
echo "2.不备份，生存新证书和新线路"
	read xianlusave
	if [[ "$xianlusave" == "2" ]]
		then
			xianlusave=2
		else
			xianlusave=1
		fi
	echo
		echo "是否需要备份用户前台"
		echo "1.备份"
		echo "2.替换全新流控前台(回车默认)"
		read usersave
		if [[ "$usersave" == "1" ]]
		then
			usersave=1
		else
			usersave=2
		fi
		echo
		echo "回车设置实时监控程序！"
		read jiankongs
		if [[ -z $jiankongs ]]
		then
		jiankongs=1
		fi

	echo 
	echo "填写完成回车开始更新流控！"
	read
		
	clear
	if [[ "$xianlusave" == "1" ]]
	then
	cp /etc/openvpn/easy-rsa/keys/ca.crt /home/ >/dev/null 2>&1
	cp /etc/openvpn/easy-rsa/ta.key /home/ >/dev/null 2>&1
	rm -rf /etc/openvpn/server.conf
	cd /etc/openvpn
echo "#################################################
#               vpn流量控制配置文件             #
#                               by：DC云免流  #
#                                  2016-05-15   #
#################################################
port 440
#your port by:Dmgml

proto tcp
dev tun
ca /etc/openvpn/easy-rsa/keys/ca.crt
cert /etc/openvpn/easy-rsa/keys/centos.crt
key /etc/openvpn/easy-rsa/keys/centos.key
dh /etc/openvpn/easy-rsa/keys/dh2048.pem
auth-user-pass-verify /etc/openvpn/login.sh via-env
client-disconnect /etc/openvpn/disconnect.sh
client-connect /etc/openvpn/connect.sh
client-cert-not-required
username-as-common-name
script-security 3 system
server 10.8.0.0 255.255.0.0
push "redirect-gateway def1 bypass-dhcp"
push "dhcp-option DNS 114.114.114.114"
push "dhcp-option DNS 114.114.115.115"
management localhost 7505
keepalive 10 120
tls-auth /etc/openvpn/easy-rsa/ta.key 0  
comp-lzo
persist-key
persist-tun
status /home/wwwroot/default/res/openvpn-status.txt
log         openvpn.log
log-append  openvpn.log
verb 3
#dmkuai.com" >/etc/openvpn/server.conf
	rm -rf /root/${mp}
	cd /root
	curl -O ${http}${Host}/${Vpnfile}/${mp}
	chmod 0777 ./${mp} >/dev/null 2>&1
	vpnport=440
	mpport=8080
	rm -rf /bin/vpn
	echo "正在加入所有软件快捷启动命令：vpn"
	echo "正在重启openvpn服务...
	mkdir /dev/net; mknod /dev/net/tun c 10 200 >/dev/null 2>&1
	killall openvpn >/dev/null 2>&1
	systemctl stop openvpn@server.service
	systemctl start openvpn@server.service
	(以上为开启openvpn,提示乱码是正常的)
	killall mproxy-Dmg >/dev/null 2>&1
	cd /root/
	./mproxy-Dmg -l $mpport -d
	killall squid >/dev/null 2>&1
	killall squid >/dev/null 2>&1
	squid -z >/dev/null 2>&1
	systemctl restart squid
	lnmp
	lamp
	echo -e '服务状态：			  [\033[32m  OK  \033[0m]'
	exit 0;
	" >/bin/vpn >/dev/null 2>&1
	chmod 777 /bin/vpn
	else
		rm -rf /etc/openvpn/easy-rsa/
		rm -rf /etc/openvpn/server.conf
		vpnport=440
		cd /etc/openvpn
	    echo "#################################################
#               vpn流量控制配置文件             #
#                               by：DC云免流  #
#                                  2016-05-15   #
#################################################
port 440
#your port by:Dmgml

proto tcp
dev tun
ca /etc/openvpn/easy-rsa/keys/ca.crt
cert /etc/openvpn/easy-rsa/keys/centos.crt
key /etc/openvpn/easy-rsa/keys/centos.key
dh /etc/openvpn/easy-rsa/keys/dh2048.pem
auth-user-pass-verify /etc/openvpn/login.sh via-env
client-disconnect /etc/openvpn/disconnect.sh
client-connect /etc/openvpn/connect.sh
client-cert-not-required
username-as-common-name
script-security 3 system
server 10.8.0.0 255.255.0.0
push "redirect-gateway def1 bypass-dhcp"
push "dhcp-option DNS 114.114.114.114"
push "dhcp-option DNS 114.114.115.115"
management localhost 7505
keepalive 10 120
tls-auth /etc/openvpn/easy-rsa/ta.key 0  
comp-lzo
persist-key
persist-tun
status /home/wwwroot/default/res/openvpn-status.txt
log         openvpn.log
log-append  openvpn.log
verb 3
#dmkuai.com" >/etc/openvpn/server.conf
	   cd /etc/openvpn/
	   curl -O ${http}${Host}/${Vpnfile}/${RSA}
	   tar -zxvf ${RSA} >/dev/null 2>&1
	   rm -rf /etc/openvpn/${RSA}
	   cd /etc/openvpn/easy-rsa/
	   sleep 1
	   source vars >/dev/null 2>&1
	   ./clean-all
	   clear
	   echo "正在生成CA和证书文件..."
	   echo 
	   sleep 2
	   ./ca && ./centos centos >/dev/null 2>&1
	   echo 
	   echo "证书创建完成"
	   echo 
	   sleep 2
	   echo "正在生成TLS密钥..."
	   openvpn --genkey --secret ta.key
	   echo "完成！"
	   sleep 1
	   clear
	echo -e '\033[33m╒========================================================================╕\033[0m'
	echo -e '\033[33m│ ☆-即将开始生产SSL加密证书           										  \033[0m'
	echo -e '\033[33m│ ☆-这是个漫长的过程         	                              \033[0m'
	echo -e '\033[33m│ ☆-速度看机器配置         	                                          \033[0m'
	echo -e '\033[33m│ ☆-这里必须注意                              	          \033[0m'
	echo -e '\033[33m│ ☆-回车之后生成证书期间请勿在移动鼠标进行任何操作						      \033[0m'
	echo -e '\033[33m│ ☆-回车开始生成   ------>  		  								      \033[0m'
	echo -e '\033[33m╘\033[0m'
	read
	   ./build-dh
	   echo
	   echo "生成完毕！"
	   rm -rf /home/ca.crt
	   rm -rf /home/ta.eky
	   rm -rf /home/kangml-openvpn.tar.gz
   		cp /etc/openvpn/easy-rsa/keys/ca.crt /home/ >/dev/null 2>&1
   		cp /etc/openvpn/easy-rsa/ta.key /home/ >/dev/null 2>&1
		mpport=8080
		rm -rf /bin/vpn
		echo "正在加入所有软件快捷启动命令：vpn"
		echo "正在重启openvpn服务...
		mkdir /dev/net; mknod /dev/net/tun c 10 200 >/dev/null 2>&1
		killall openvpn >/dev/null 2>&1
		systemctl stop openvpn@server.service
		systemctl start openvpn@server.service
		(以上为开启openvpn,提示乱码是正常的)
		killall mproxy-Dmg >/dev/null 2>&1
		cd /root/
		./mproxy-Dmg -l $mpport -d
		killall squid >/dev/null 2>&1
		killall squid >/dev/null 2>&1
		squid -z >/dev/null 2>&1
		systemctl restart squid
		lnmp
		lamp
		echo -e '服务状态：			  [\033[32m  OK  \033[0m]'
		exit 0;
		" >/bin/vpn >/dev/null 2>&1
		chmod 777 /bin/vpn
   fi
   echo "正在更新配置文件..."
		iptables -A INPUT -p TCP --dport $mpport -j ACCEPT
		iptables -A INPUT -p TCP --dport $sqport -j ACCEPT
		iptables -A INPUT -p TCP --dport $vpnport -j ACCEPT
		service iptables save
		systemctl restart iptables
		rm -rf /root/${mp}
		cd /root
		wget ${http}${Host}/${Vpnfile}/${mp}
		chmod 0777 ./${mp}
   		if [[ "$usersave" == "1" ]]
		then
			mv -f /home/wwwroot/default/user/ /home/
		fi
		
		mv -f /home/wwwroot/default/config.php /home/
		sleep 1
		
		killall jiankong
		rm -rf /home/wwwroot/default/res/*
		cd /home/wwwroot/default/res/
		wget ${http}${Host}/${Vpnfile}/${jiankongfile} >/dev/null 2>&1
		unzip ${jiankongfile} >/dev/null 2>&1
		rm -rf ${jiankongfile}
		chmod 777 jiankong
		chmod 777 sha
		sed -i 's/shijian=1/'shijian=$jiankongs'/g' /home/wwwroot/default/res/ >/dev/null 2>&1
		rm -rf /etc/openvpn/sqlmima
		echo "mima=$oldsqlpass">>/etc/openvpn/sqlmima
		chmod 777 /etc/openvpn/sqlmima
		/home/wwwroot/default/res/jiankong >>/home/jiankong.log 2>&1 &
		
		cd /root
		rm -rf /root/dmg/
		rm -rf ${webfile}
		wget ${http}${Host}/${Vpnfile}/${webfile}
unzip -q ${webfile}<<EOF
A
EOF
		rm -rf /root/dmg/web/config.php
		sed -i 's/123456/'$oldsqlpass'/g' ./dmg/sh/login.sh >/dev/null 2>&1
		sed -i 's/123456/'$oldsqlpass'/g' ./dmg/sh/disconnect.sh >/dev/null 2>&1
		mv -f ./dmg/sh/login.sh /etc/openvpn/
		mv -f ./dmg/sh/disconnect.sh /etc/openvpn/
		mv -f ./dmg/sh/connect.sh /etc/openvpn/
		chmod +x /etc/openvpn/*.sh >/dev/null 2>&1
		chmod 777 -R ./dmg/web/* >/dev/null 2>&1
		mv -f /root/dmg/web/* /home/wwwroot/default/
		rm -rf /root/dmg/
		rm -rf ${webfile}
		
		echo "恢复文件中"
		sleep 1
		rm -rf /home/wwwroot/default/config.php
		mv /home/config.php /home/wwwroot/default/
		sleep 1
		cd /home/wwwroot/
		chmod 777 -R default
   		if [[ "$usersave" == "1" ]]
		then
			rm -rf /home/wwwroot/default/user/
			mv -f /home/user/ /home/wwwroot/default/user/
		fi
		
	vpn
		ovpn
		pkgovpn
		echo
		echo "更新完成"
		rm -rf url >/dev/null 2>&1
		rm -rf /etc/openvpn/ca >/dev/null 2>&1
		exit 0;
else
vpnportseetings
readytoinstall
newvpn
installlnmp
webml
ovpn
webmlpass
echo "正在为您开启Mproxy..."
sleep 3
cd /root/
chmod 0777 ./${mp} >/dev/null 2>&1
./${mp} -l $mpport -d >/dev/null 2>&1
sleep 5
pkgovpn
fi
echo "$finishlogo";
rm -rf url >/dev/null 2>&1
rm -rf /etc/openvpn/ca >/dev/null 2>&1
return 1
}
main
exit 0;
#版权所有：DC云免流