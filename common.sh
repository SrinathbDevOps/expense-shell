log_file = /tmp/backend.log
log_file1 = /tmp/frontend.log
log_file2 = /tmp/mysql.log

download_extract() {

curl -s -o /tmp/$component.zip https://expense-artifacts.s3.amazonaws.com/$component.zip

unzip /tmp/$component.zip >>/tmp/$component.log

}


enable_service_restart () {
  echo restarting $component service
  systemctl daemon-reload >>$log_file
  systemctl enable $component >>$log_file
  systemctl restart $component >>$log_file
}