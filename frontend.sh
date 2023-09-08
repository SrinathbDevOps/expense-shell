source = common.sh
component = frontend
echo "********* Install nginx webserver *************"
dnf install nginx -y >>log_file1
cp expense.conf /etc/nginx/default.d/expense.conf

enable_service_restart

echo "************ remove default nginx static content **********"
rm -rf /usr/share/nginx/html/*

echo "download $component app & host the application in app directory***********"
cd /usr/share/nginx/html
download_extract

echo "********** restart nginx server    ************ "
systemctl restart nginx >>$log_file1