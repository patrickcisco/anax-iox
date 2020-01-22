APP_NAME := "alpine37-docker.v1.0"

build:
	rm -rf output; mkdir output
	cp package.yaml output/
	cp images/${APP_NAME}.qcow2 output/
	ioxclient package --name ${APP_NAME} output