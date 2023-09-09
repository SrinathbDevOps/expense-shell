source common.sh
component=mysqld

echo Disable existing mysql version 8
dnf module disable mysql -y >>log_file
status_check

echo Create mysql repo in yum repository
cp mysql.repo /etc/yum.repos.d/mysql.repo &>>log_file
status_check

echo Install MySQL 5.7 Community Server
dnf install mysql-community-server -y >>log_file
status_check

echo Enable mysqld service and start service
systemctl daemon-reload &>>$log_file
systemctl enable mysqld &>>$log_file
systemctl restart mysqld &>>$log_file
status_check

echo Set mysql root password
mysql_root_password=$1
mysql_secure_installation --set-root-pass $mysql_root_password &>>log_file
status_check
