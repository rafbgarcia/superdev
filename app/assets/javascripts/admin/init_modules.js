angular.module('SuperDevAdmin', [
  'CodeQuestion',
  'ui.ace',
]);

angular.module('CodeQuestion', []);


$(document).on('ready page:load', function() {
  angular.bootstrap(document.body, ['SuperDevAdmin']);
});
