#!/bin/bash

fw_depends mysql postgresql mongodb java maven

mvn clean package
cd target/dist
unzip *.zip


APP_ENTRY=com.techempower.act.AppEntry

DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
BASE=$DIR
CP=$BASE/classes:$BASE/lib/*
echo CLASSPATH: $CP
echo

JAVA_OPTS="-Djava.security.egd=file:/dev/./urandom -Dawt.useSystemAAFontSettings=on -server -Xms512m -Xmx2g"

java -server $JAVA_OPTS -Dapp.mode=prod -Dapp.nodeGroup=$GROUP -Dprofile=prod -Dmongo.host=${DBHOST} -Dmysql.host=${DBHOST} -Dpgsql.host=${DBHOST} -cp "$CP" $APP_ENTRY &
