$(document).on('turbolinks:load', function() {
  for (var i in window) {
      if (/^addthis/.test(i) || /^_at/.test(i)) {
          delete window[i];
      }
  }
  window.addthis_share = null;

  $.getScript("//s7.addthis.com/js/300/addthis_widget.js#pubid=ra-58e8099e2e955bd7");
});
