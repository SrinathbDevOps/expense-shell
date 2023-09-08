source = common.sh
component = mysqld

echo "********** disable existing mysql version **********"
dnf module disable mysql -y >>log_file2

echo "******* create mysql repo in yum repository *************"
cp mysql.repo /etc/yum.repos.d/mysql.repo >>log_file2

echo "********** Install MySQL 5.7 Community Server ******************"
dnf install mysql-community-server -y >>log_file2

echo "********** enable mysqld service & start **************"
enable_service_restart

echo "************* set mysql root password ************"
mysql_secure_installation --set-root-pass ExpenseApp@1 >>log_file2
