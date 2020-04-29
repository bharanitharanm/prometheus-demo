# Prometheus-demo
## Setup - Prometheus
1. Download and Extract 
    ```
    $ wget https://github.com/prometheus/prometheus/releases/download/v2.18.0-rc.0/prometheus-2.18.0-rc.0.linux-amd64.tar.gz
    $ tar -xf prometheus-2.18.0-rc.0.linux-amd64.tar.gz
    ```
2. Start prometheus     
    ```
    $ cd prometheus-2.18.0-rc.0.linux-amd64/
    $ ./prometheus
    ```
3. Prometheus console can be accessed by `http://localhost:9090`    
4. By default Prometheus will monitor itself `http://localhost:9090/targets`  
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
    "http://localhost:3000/" - Total number of requests to this endpoint will be monitored
    "http://localhost:3000/metrics" - Endpoint used by Prometheus to get the metrics
    
    $ curl http://localhost:3000/metrics
    # HELP total_http_request_count Total number of HTTP requests
    # TYPE total_http_request_count counter
    total_http_request_count 0
    
    $ curl http://localhost:3000/
    HelloWorld!!
    
    $ curl http://localhost:3000/metrics
    # HELP total_http_request_count Total number of HTTP requests
    # TYPE total_http_request_count counter
    total_http_request_count 1 
    ```
## Add Node application for monitoring
1. In `prometheus.yml` add the Node application for monitoring under `scrape_configs`
    ```
    - job_name: 'node-app'
      static_configs:
      - targets: ['localhost:3000']
    ``` 
2. Now the `node-app` application will be listed in targets `http://localhost:9090/targets` (Status will be shown as `UP` or `DOWN` based on the service status)
## Alerts
### Alert Rules
Alerts will be generated by Prometheus based on the configured alert rules.
1. Create Alert Rules in yml format. 
   Alert rule if application goes down
    ```
    - alert: InstanceDown
      expr: up == 0
      for: 1m
      labels:
        severity: "critical"
      annotations:
        title: 'Instance {{ $labels.instance }} down'
        description: '{{ $labels.instance }} of job {{ $labels.job }} has been down for more than 1 minute.'
    ```
   Alert Rule for every 5 new requests
    ```
    - alert: RequestLimit
      expr: total_http_request_count != 0 and total_http_request_count%5 == 0
      for: 10s
      labels:
        severity: "critical"
      annotations:
        title: '5 New requests received'
        description: '5 New HTTP requests received for node-app'
    ```
2. Adding Alert rules to Prometheus. In `prometheus.yml`
    ```
    rule_files:
      - "alert_rules.yml"
    ```
### Setting up Alert Manager
Alerts generated by Prometheus server are sent to Alert Manager which manages the alerts and sends the nofications
1. Download and Extract Alert Manager
    ```
    $ wget https://github.com/prometheus/alertmanager/releases/download/v0.20.0/alertmanager-0.20.0.linux-amd64.tar.gz
    $ tar -xf alertmanager-0.20.0.linux-amd64.tar.gz
    ```
2. Start Alert Manager
    ```
    $ cd alertmanager-0.20.0.linux-amd64/
    $ ./alertmanager
    ```
3. Alert Manager console can be accessed by `http://localhost:9093`    
4. Configure Alert Manager in Prometheus. In `prometheus.yml` add the below
    ```
    alerting:
      alertmanagers:
      - static_configs:
        - targets:
          - localhost:9093
    ```
