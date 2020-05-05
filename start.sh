#!/bin/bash

# Start Node Application
docker run mbharanitharan/prometheus-poc:latest

# Setup and Start Prometheus
wget https://github.com/prometheus/prometheus/releases/download/v2.18.0-rc.0/prometheus-2.18.0-rc.0.linux-amd64.tar.gz
tar -xf prometheus-2.18.0-rc.0.linux-amd64.tar.gz
cd prometheus-2.18.0-rc.0.linux-amd64/
cp prometheus/* prometheus-2.18.0-rc.0.linux-amd64/ 
./prometheus

# Setup and Start Alert Manager
cd ../
wget https://github.com/prometheus/alertmanager/releases/download/v0.20.0/alertmanager-0.20.0.linux-amd64.tar.gz
tar -xf alertmanager-0.20.0.linux-amd64.tar.gz
cd alertmanager-0.20.0.linux-amd64/
cp alert-manager/* alertmanager-0.20.0.linux-amd64/
./alertmanager
