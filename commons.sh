#!/bin/bash

USERID=$(id -u)
TIMESTAMP=$(date +%F-%H-%M-%S)
SCRIPT_NAME=$(echo $0 | cut -d "." -f1)
LOG_FILE=/tmp/$SCRIPT_NAME-$TIMESTAMP.log
R="\e[31m"
G="\e[32m"
N="\e[0m"
Y="\e[33m"

check_root(){
    if [ $USERID -ne 0 ]
    then
        echo -e " $R please run with super user access $N"
    else
        echo -e "$G You are a super user $N"
    fi

}


VALIDATE(){
    if [ $1 -ne 0 ]
    then
        echo -e  "$2 ....$R FAILED $N"
        exit 1
    else
        echo -e "$2..... $G SUCCESS $N"
    fi
}
