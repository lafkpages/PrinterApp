class PrinterError extends Error {
  constructor(message) {
    super(message);
    this.name = 'PrinterError';
  }
}

class PrinterApp {
  constructor(ip, options = {}) {
    if (typeof ip == 'string')
      ip = ip.trim();

    if (ip == '' || ip == undefined || ip == null || (typeof ip == 'number' && ip < 0)) {
      throw new TypeError(`must specify a valid IP address (passed ${ip})`);
    }

    if (typeof ip == 'number')
      ip = `192.168.1.${ip}`;

    this.ip = ip;
    this.https = !!options.https || false;
  }

  get host() {
    return `http${this.https? 's' : ''}://${this.ip}`;
  }

  async getLocalizations() {
    return await (await fetch(this.host + '/localize.json')).json();
  }
}