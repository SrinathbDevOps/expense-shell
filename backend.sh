source common.sh
component=backend

type npm &>>$log_file
if [ $? -ne 0 ]; then
  echo Install NodeJS Repo
  curl -sL https://rpm.nodesource.com/setup_lts.x | bash >>$log_file
  status_check

  echo Installing NodeJs
  dnf install nodejs -y >>log_file
  status_check
fi

echo Add expense user
id expense &>>$log_file
if [ $? -ne 0]; then
  useradd expense >>log_file
fi
status_check

echo copy backend service file
cp $component.service /etc/systemd/system/$component.service &>>log_file
status_check
echo Cleanup app directory
rm -rf /app >>$log_file
status_check

echo Create app directory
mkdir /app
cd /app

echo Download and Extract $component
download_extract

echo Install Backend Service
npm install >>$log_file
status_check

echo Restart Service
enable_service_restart

echo Install mysql client
dnf install mysql -y >>log_file
status_check

echo Load Schema
mysql_root_password=$1
mysql -h mysql.sbdevops.online -uroot -p$mysql_root_password < /app/schema/backend.sql >>log_file
status_check