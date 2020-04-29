const express=require("express");
const Prometheus=require("prom-client");
const app=express();

const counter = new Prometheus.Counter({
  name: "total_http_request_count",
  help: "Total number of HTTP requests",
});

app.get("", (req,res) => {
    counter.inc(); // Inc with 1
    res.end("HelloWorld!!");
});

app.get("/metrics",(req, res) => {
    res.set('Content-Type', Prometheus.register.contentType);
    res.end(Prometheus.register.metrics());
});

app.listen(3000);
