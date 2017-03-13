/**
 * Used in views/items/_discussions
 *
 * View params:
 */

(function (angular) {

  angular.module('Discussion').controller('UpvoteCtrl', [
    '$scope', '$http',
    DiscussionCtrl
  ]);

  function DiscussionCtrl($scope, $http) {

  }

})(angular);
