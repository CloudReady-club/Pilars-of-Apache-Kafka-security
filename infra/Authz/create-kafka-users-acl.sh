#!/bin/bash

PRODUCER_USER="producer"
PRODUCER_PASSWORD="P@ssMordProducerScram"

CONSUMER_USER="consumer"
CONSUMER_PASSWORD="P@ssMordConsumerScram"

TOPIC_TEST="myTestTopic"
CONSUMER_GROUP="consumer.group-1"

#Add Path to kafka bin folder
KAFKA_BIN_FOLDER=~/Documents/work/kafka_2.13-3.1.0/bin
chmod +x ${KAFKA_BIN_FOLDER}/kafka-configs.sh
chmod +x ${KAFKA_BIN_FOLDER}/kafka-acls.sh


${KAFKA_BIN_FOLDER}/kafka-configs.sh --zookeeper localhost:12181 --alter \
        --add-config 'SCRAM-SHA-512=[password='${PRODUCER_PASSWORD}']' \
        --entity-type users \
        --entity-name $PRODUCER_USER

${KAFKA_BIN_FOLDER}/kafka-configs.sh --zookeeper localhost:12181 --alter \
        --add-config 'SCRAM-SHA-512=[password='${CONSUMER_PASSWORD}']' \
        --entity-type users \
        --entity-name $CONSUMER_USER

${KAFKA_BIN_FOLDER}/kafka-acls.sh \
  --bootstrap-server broker-1:9291 \
  --list \
  --command-config ./admin.properties

${KAFKA_BIN_FOLDER}/kafka-topics.sh \
  --bootstrap-server broker-1:9291 \
  --create \
  --topic $TOPIC_TEST \
  --partitions 3 
  --command-config ./admin.properties

${KAFKA_BIN_FOLDER}/kafka-acls.sh \
  --bootstrap-server broker-1:9291 \
  --add \
  --allow-principal User:$PRODUCER_USER \
  --operation WRITE \
  --topic $TOPIC_TEST \
  --command-config ./admin.properties

${KAFKA_BIN_FOLDER}//kafka-acls.sh \
  --bootstrap-server broker-1:9291 \
  --add \
  --allow-principal User:$CONSUMER_USER \
  --operation READ \
  --topic $TOPIC_TEST \
  --command-config ./admin.properties

${KAFKA_BIN_FOLDER}//kafka-acls.sh \
  --bootstrap-server broker-1:9291 \
  --add \
  --allow-principal User:$CONSUMER_USER \
  --operation All \
  --group $CONSUMER_GROUP \
  --command-config ./admin.properties