angular.module('SuperDevAdmin', [
  'CodeQuestion',
  'ui.ace',
]);

angular.module('CodeQuestion', []);


$(document).on('turbolinks:load', function() {
  angular.bootstrap(document.body, ['SuperDevAdmin']);
});
