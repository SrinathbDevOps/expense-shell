echo "**********Downloading nodejs dependencies for installing nodejs **********"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash

echo "********* Installing Nodejs ************"
dnf install nodejs -y >> backend.log
echo "Add expense user ******"
useradd expense >> backend.log

echo "****** create backend service **********"
cp backend.service /etc/systemd/system/backend.service
echo "Create app directory & Host backend app ********"
rm -rf /app
mkdir /app

curl -s -o /tmp/backend.zip https://expense-artifacts.s3.amazonaws.com/backend.zip
cd /app
unzip /tmp/backend.zip >> backend.log

echo "*********install backend app ***********"
npm install >> backend.log
systemctl daemon-reload >> backend.log
systemctl enable backend >> backend.log
systemctl restart backend >> backend.log
echo "**********Install mysql client & load scheme ***************"
dnf install mysql -y >> backend.log
mysql -h mysql.sbdevops.online -uroot -pExpenseApp@1 < /app/schema/backend.sql >> backend.log