// (function (global) {
//   var loadCount = 0;

//   $(document).on('turbolinks:load', function() {
//     if (loadCount++ === 0) {
//       // avoid JS errors
//       return;
//     }

//     for (var i in global) {
//       if (/^addthis/.test(i) || /^_at/.test(i)) {
//         delete global[i];
//       }
//     }
//     global.addthis_share = null;

//     $.getScript("//s7.addthis.com/js/300/addthis_widget.js#pubid=ra-58e8099e2e955bd7");
//   });
// })(window);
