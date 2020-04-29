# Prometheus-demo
## Setup - Prometheus
1. Download Prometheus `wget https://github.com/prometheus/prometheus/releases/download/v2.18.0-rc.0/prometheus-2.18.0-rc.0.linux-amd64.tar.gz`    
2. Extract package `tar -xf prometheus-2.18.0-rc.0.linux-amd64.tar.gz`    
3. Start prometheus `cd prometheus-2.18.0-rc.0.linux-amd64/` `./prometheus`    
4. Prometheus console can be accessed by `http://localhost:9090`    
5. By default Prometheus will monitor itself `http://localhost:9090/targets`  
## Node Application (Application to be Monitored)
1. Install Node.js    
    ```
    $ wget https://nodejs.org/dist/v12.16.3/node-v12.16.3-linux-x64.tar.xz
    $ tar -xf node-v12.16.3-linux-x64.tar.xz
    ```
2. Set `node-v12.16.3-linux-x64/bin` to class path and verify using `node -v`    
3. Start the node application    
    ```
    $ cd app/
    $ npm install
    $ node index.js
    ```
4. Has two endpoints    
    ```
    "http://localhost:3000/" - Requests to this endpoint will be monitored
    "http://localhost:3000/metrics" - Endpoint used by Prometheus to get the metrics
    ```
5. 

