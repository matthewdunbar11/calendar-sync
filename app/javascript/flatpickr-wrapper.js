import flatpickr from 'flatpickr';
import 'flatpickr/dist/flatpickr.css';

document.addEventListener("turbolinks:load", function() {
  var inputs = document.querySelectorAll("input[type=datetime-local]");
  inputs.forEach(e => flatpickr(e, {
    enableTime: true,
    altInput: true
  }));
});

