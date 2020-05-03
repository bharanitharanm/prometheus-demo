class Counter {
  count = 0;

  constructor(name, help) {
    this.name = name;
    this.help = help;
  }

  inc() {
    this.count++;
  }

  metrics() {
    var metric = `#HELP ${this.name} ${this.help}\n#TYPE ${this.name} counter\n${this.name} ${this.count}\n`;
    return metric;
  }
}

module.exports = Counter;

