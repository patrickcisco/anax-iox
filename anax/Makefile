APP := "anaxcisco"
VERSION := "v001"

build:
	docker build --build-arg HZN_EXCHANGE_USER_AUTH=${HZN_EXCHANGE_USER_AUTH} \
				 --build-arg HZN_EXCHANGE_NODE_AUTH=${HZN_EXCHANGE_NODE_AUTH} \
				 --build-arg CLUSTER_ID=${CLUSTER_ID} \
				 . -t ${APP}