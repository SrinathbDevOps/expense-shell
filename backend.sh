source = common.sh
component = backend

echo "**********Downloading nodejs dependencies for installing nodejs **********"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash

echo "********* Installing Nodejs ************"
dnf install nodejs -y >>log_file
echo "******Add expense user ******"
useradd expense >>log_file

echo "****** create backend service **********"
cp $component.service /etc/systemd/system/$component.service
echo "Create app directory & Host backend app ********"
rm -rf /app
mkdir /app
cd /app
echo download & extract $component
download_extract

echo "*********install backend app ***********"
npm install >>$log_file

echo "Restart services"
enable_service_restart

echo "**********Install mysql client & load scheme ***************"
dnf install mysql -y >>log_file
mysql -h mysql.sbdevops.online -uroot -pExpenseApp@1 < /app/schema/backend.sql >>log_file