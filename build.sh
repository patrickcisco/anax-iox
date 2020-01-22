#! /bin/bash -x
APP_NAME="alpine37-docker.v1.0"

if [ ! -d output ]; then
	mkdir -p output
else
	rm -rf output/*
fi

if [ $? == 0 ]; then
   cp package.yaml output/
   cp images/$APP_NAME.qcow2 output/
   ioxclient package --name $APP_NAME output
else
   echo "$APP_NAME KVM build not successful"
fi