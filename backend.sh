echo "**********Downloading nodejs dependencies for installing nodejs **********"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash

echo "********* Installing Nodejs ************"
dnf install nodejs -y >>/tmp/backend.log
echo "Add expense user ******"
useradd expense >>/tmp/backend.log

echo "****** create backend service **********"
cp backend.service /etc/systemd/system/backend.service
echo "Create app directory & Host backend app ********"
rm -rf /app
mkdir /app

curl -s -o /tmp/backend.zip https://expense-artifacts.s3.amazonaws.com/backend.zip
cd /app
unzip /tmp/backend.zip >>/tmp/backend.log

echo "*********install backend app ***********"
npm install >>/tmp/backend.log
systemctl daemon-reload >>/tmp/backend.log
systemctl enable backend >>/tmp/backend.log
systemctl restart backend >>/tmp/backend.log
echo "**********Install mysql client & load scheme ***************"
dnf install mysql -y >>/tmp/backend.log
mysql -h mysql.sbdevops.online -uroot -pExpenseApp@1 < /app/schema/backend.sql >>/tmp/backend.log