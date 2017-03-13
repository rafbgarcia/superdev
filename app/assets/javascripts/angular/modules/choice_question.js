/**
 * Used in views/items/_choice_question
 *
 * View params:
 * @param String item_answers_path
 * @param Object answered_alternative Alternative or {}. This is set when the item has been answered
 */

(function (angular) {

  angular.module('Question').controller('ChoiceQuestionCtrl', [
    '$scope', '$http', 'User', 'item_answers_path', 'answered_alternative',
    ChoiceQuestionCtrl
  ]);

  function ChoiceQuestionCtrl($scope, $http, User, item_answers_path, answered_alternative) {
    setScope($scope, answered_alternative);

    $scope.answer = function () {
      var data = {alternative_id: $scope.alternative.id};

      $http.post(item_answers_path, data).then(
        function success(resp) {
          setScope($scope, resp.data.alternative);
          User.update_level(resp.data.user);
        },
        function error(resp) {
          $scope.error_message = resp.data.error_message;
        }
      );
    };
  };

  function setScope($scope, answered_alternative) {
    $scope.alternative = answered_alternative;
    $scope.item = {answered: !!answered_alternative.id};
  }

})(angular);
