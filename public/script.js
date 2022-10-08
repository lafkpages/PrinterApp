const getParams = new URLSearchParams(window.location.search);
let ip = getParams.get('ip');

let ipForm = document.querySelector('form#ip-form');

let printer = null;

if (ip) {
  ipForm.style.display = 'none';

  printer = new PrinterApp(ip);
}