angular.module('SuperDev', [
  'Question',
  'User',
  'Discussion',
  'ui.ace',
]);

angular.module('User', []);
angular.module('Question', []);
angular.module('Discussion', []);

$(document).on('turbolinks:load', function() {
  angular.bootstrap(document.body, ['SuperDev']);
});
