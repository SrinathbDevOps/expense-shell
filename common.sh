log_file = /tmp/expense.log
download_and_extract() {
echo download $component
curl -s -o /tmp/$component.zip https://expense-artifacts.s3.amazonaws.com/$component.zip >>$log_file
status_check
echo extract $component
unzip /tmp/$component.zip >>$log_file
status_check
}


enable_service_restart() {
  echo Daemon-reload for $component service
  systemctl daemon-reload >>$log_file
  status_check
  echo Enable server for $component service
  systemctl enable $component >>$log_file
  status_check
  echo Restart service for $component service
  systemctl restart $component >>$log_file
  status_check
}

status_check(){
  if [$? eq 0]; then
    echo -e "\e[32mSUCCESS\e[0m"
  else
    echo -e "\e[31mFAILED\e[0m"
    exit 1
  fi
}