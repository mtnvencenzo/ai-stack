#!/bin/bash
set -e

# First, generate the Kafka configuration
echo "Generating Kafka configuration..."
/etc/confluent/docker/configure

# Check if storage has been formatted by looking for meta.properties
if [ ! -f /var/lib/kafka/data/meta.properties ]; then
  echo "Storage not formatted. Formatting now..."
  kafka-storage format -t ${CLUSTER_ID} -c /etc/kafka/kafka.properties
  echo "Storage formatted successfully."
else
  echo "Storage already formatted. Skipping format step."
fi

# Start Kafka
echo "Starting Kafka broker..."
/etc/confluent/docker/launch
