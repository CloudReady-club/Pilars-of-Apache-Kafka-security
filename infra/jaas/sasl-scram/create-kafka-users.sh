#!/bin/bash

PRODUCER_USER="producer"
PRODUCER_PASSWORD="P@ssMordProducerScram"

CONSUMER_USER="consumer"
CONSUMER_PASSWORD="P@ssMordConsumerScram"

#Add Path to kafka bin folder
KAFKA_BIN_FOLDER=~/Documents/work/kafka_2.13-3.1.0/bin
chmod +x ${KAFKA_BIN_FOLDER}/kafka-configs.sh


${KAFKA_BIN_FOLDER}/kafka-configs.sh --zookeeper localhost:12181 --alter \
        --add-config 'SCRAM-SHA-512=[password='${PRODUCER_PASSWORD}']' \
        --entity-type users \
        --entity-name $PRODUCER_USER

${KAFKA_BIN_FOLDER}/kafka-configs.sh --zookeeper localhost:12181 --alter \
        --add-config 'SCRAM-SHA-512=[password='${CONSUMER_PASSWORD}']' \
        --entity-type users \
        --entity-name $CONSUMER_USER