#!/bin/bash

set -e

echo "Running entrypoint script for RabbitMQ clustering"
echo ""
echo ""
echo "Starting RabbitMQ Server... "

if [ -z "$CLUSTER_WITH" ]; then
  echo "Starting in standalone mode"
  /usr/local/bin/docker-entrypoint.sh rabbitmq-server
  rabbitmqctl stop_app
  rabbitmqctl reset
  rabbitmqctl stop
  sleep 2
  rabbimq-server
  
else
  echo "Begin clustering mode"
  /usr/local/bin/docker-entrypoint.sh rabbitmq-server -detached
  sleep 2
  rabbitmqctl stop_app
  rabbitmqctl reset

  if [ -z "$RAM_NODE" ]; then
      rabbitmqctl join_cluster rabbit@$CLUSTER_WITH
    else
      rabbitmqctl join_cluster --ram rabbit@$CLUSTER_WITH
  fi
  
  rabbitmqctl stop
  sleep 2
  rabbitmq-server
fi
