
echo "********** disable existing mysql version **********"
dnf module disable mysql -y >>/tmp/mysql.log

echo "******* create mysql repo in yum repository *************"
cp mysql.repo /etc/yum.repos.d/mysql.repo >>/tmp/mysql.log

echo "********** Install MySQL 5.7 Community Server ******************"
dnf install mysql-community-server -y >>/tmp/mysql.log

echo "********** enable mysql service & start **************"
systemctl enable mysqld >>/tmp/mysql.log
systemctl start mysqld >>/tmp/mysql.log

echo "************* set mysql root password ************"
mysql_secure_installation --set-root-pass ExpenseApp@1 >>/tmp/mysql.log
