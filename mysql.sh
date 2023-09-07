
echo "********** disable existing mysql version **********"
dnf module disable mysql -y >> mysql.log

echo "******* create mysql repo in yum repository *************"
cp mysql.repo /etc/yum.repos.d/mysql.repo >> mysql.log

echo "********** Install MySQL 5.7 Community Server ******************"
dnf install mysql-community-server -y >> mysql.log

echo "********** enable mysql service & start **************"
systemctl enable mysqld >> mysql.log
systemctl start mysqld >> mysql.log

echo "************* set mysql root password ************"
mysql_secure_installation --set-root-pass ExpenseApp@1 >> mysql.log
