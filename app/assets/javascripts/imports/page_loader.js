// Page loader

var timeout;
$(document).on('page:fetch', function () {
  timeout = window.setTimeout(function () {
    $('#page-loading').addClass('shown');
  }, 300);
});

$(document).on('page:receive', function () {
  window.clearTimeout(timeout);
  $('#page-loading').removeClass('shown');
});

