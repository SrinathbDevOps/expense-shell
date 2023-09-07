echo "********* Install nginx webserver *************"
dnf install nginx -y >> frontend.log
cp expense.conf /etc/nginx/default.d/expense.conf
systemctl enable nginx
systemctl start nginx

echo "************ remove default nginx static content **********"
rm -rf /usr/share/nginx/html/*

echo "download frontend app & host the application in app directory***********"
curl -s -o /tmp/frontend.zip https://expense-artifacts.s3.amazonaws.com/frontend.zip
cd /usr/share/nginx/html
unzip /tmp/frontend.zip >> frontend.log

echo "********** restart nginx server    ************ "
systemctl restart nginx >> frontend.log