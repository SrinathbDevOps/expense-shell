source common.sh
component=frontend
echo Install nginx Server
dnf install nginx -y &>>$log_file
status_check
echo Placing expense config file in nginx
cp expense.conf /etc/nginx/default.d/expense.conf >>$log_file
status_check

#enable_service_restart

echo Remove default nginx content
rm -rf /usr/share/nginx/html/* >>$log_file
status_check


cd /usr/share/nginx/html
echo Download $component
download_extract

echo Start nginx service
systemctl enable nginx &>>log_file
systemctl restart nginx &>>log_file
status_check