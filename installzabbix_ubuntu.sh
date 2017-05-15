#! /bin/bash
echo "Chuong trinh cai dat zabbix server"
echo "Tai zabbix 3.0"
name=`cat /etc/issue.net | awk 'FNR == 1 {print}' | awk '{print $1}'`
echo Ban dang dung He Dieu Hanh:$name
wget http://repo.zabbix.com/zabbix/3.0/ubuntu/pool/main/z/zabbix-release/zabbix-release_3.0-1+trusty_all.deb
echo "Cai dat goi tai ve"
dpkg -i zabbix-release_3.0-1+trusty_all.deb
apt-get update
echo "Tai goi cai dat Mysql"
echo "Tao user mysql va phan quyen"
echo "Nhap MYSQL_PASS cho tai khoan root"
read p
echo "nhap ten CSDL muon tao"
read u
echo "nhap password cho CSDL muon tao" 
read pass
echo mysql-server mysql-server/root_password password $p | debconf-set-selections
echo mysql-server mysql-server/root_password_again password $p | debconf-set-selections
apt-get install zabbix-server-mysql zabbix-frontend-php -y
cat << EOF | mysql -uroot -p$p
create database $u character set utf8 collate utf8_bin;
grant all privileges on $u.* to zabbix@localhost identified by '$pass';
flush privileges;
EOF
zcat /usr/share/doc/zabbix-server-mysql/create.sql.gz | mysql -uroot -p$p $u
echo "backup lai file cau hinh"
cp /etc/zabbix/zabbix_server.conf /etc/zabbix/zabbix_server.bka
echo "sua file cau hinh"
sed -i 's/# DBHost=localhost/DBHost=localhost/g' /etc/zabbix/zabbix_server.conf
sed -i 's/# DBHost=localhost/DBName=$u/g' /etc/zabbix/zabbix_server.conf
sed -i 's/# DBHost=localhost/DBName=$u/g' /etc/zabbix/zabbix_server.conf
sed -i "s/# DBPassword=/DBPassword=$pass/g" /etc/zabbix/zabbix_server.conf
sed -i 's/# php_value date.timezone Europe\/Riga/php_value date.timezone Asia\/Ho_Chi_Minh/g' /etc/apache2/conf-enabled/zabbix.conf
echo "Khoi dong lai dich vu"
service zabbix-server start
service apache2 restart





