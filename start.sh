#!/bin/bash

echo "Starting Node application..."
# Start Node Application
docker run -p 3001:3001 -d mbharanitharan/prometheus-poc
echo "Node Application started"

echo "Starting Prometheus..."
# Setup and Start Prometheus
wget -nc https://github.com/prometheus/prometheus/releases/download/v2.18.0-rc.0/prometheus-2.18.0-rc.0.linux-amd64.tar.gz 1> /dev/null
tar -xf prometheus-2.18.0-rc.0.linux-amd64.tar.gz 1> /dev/null
cp prometheus/* prometheus-2.18.0-rc.0.linux-amd64/ 
cd prometheus-2.18.0-rc.0.linux-amd64/
./prometheus > promehteus.log 2>&1 &
echo "Prometheus started"

echo "Starting Alert Manager..."
# Setup and Start Alert Manager
cd ../
wget -nc https://github.com/prometheus/alertmanager/releases/download/v0.20.0/alertmanager-0.20.0.linux-amd64.tar.gz 1> /dev/null
tar -xf alertmanager-0.20.0.linux-amd64.tar.gz 1> /dev/null
cp alert-manager/* alertmanager-0.20.0.linux-amd64/
cd alertmanager-0.20.0.linux-amd64/
./alertmanager > alertmanager.log 2>&1 &
echo "Alert Manager started"
