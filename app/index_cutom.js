const express = require("express");
const Counter = require("./Counter");
const app = express();

const counter = new Counter(
  "total_http_request_count",
  "Total number of HTTP requests"
);

app.get("", (req, res) => {
  counter.inc(); // Inc with 1
  res.end("HelloWorld!!\n");
});

app.get("/metrics", (req, res) => {
  res.set("Content-Type", "text/plain");
  res.end(counter.metrics());
});

app.listen(3000);

