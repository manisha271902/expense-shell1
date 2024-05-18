#!/bin/bash


source ./common.sh

check_root


echo "ENter DB password"
read -s db_pswd   #kindha configure chesina root pasword eh ikada use cheyali



dnf install mysql-server -y  &>>$LOG_FILE
# VALIDATE $? "Installing MYSQL"

systemctl enable mysqld  &>>$LOG_FILE
# VALIDATE $? "Enabling mysql" 

systemctl start mysqld  &>>$LOG_FILE
# VALIDATE $? "starting mysql" 


# mysql_secure_installation --set-root-pass cherry123 &>>$LOG_FILE   
# VALIDATE $? "Setting up root usr password" 


#Belowe code is used for idempotency  nature
mysql -h db.manisha.fun -uroot -p${db_pswd} -e "show databases;" &>>$LOG_FILE
if [ $? -ne 0 ]
then
    mysql_secure_installation --set-root-pass db_pswd &>>$LOG_FILE
    VALIDATE $? "MySQL Root password setup"
else
    echo -e "mysql root password is already setup, so $Y skipping $N"
fi

    

#ikada password dynamic ga istunam ->  mysql_secure_installation -uroot cherry123 -e "show databases;" &>>$LOG_FILE
#mysql_secure_installation --set-root-pass cherry123 &>>$LOG_FILE  (ee cmd first time password set chesetapud matrame work avthadi)  