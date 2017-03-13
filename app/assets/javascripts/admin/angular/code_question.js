/**
 * Used in views/admin/items/_code_question_fields
 */

(function (angular) {

  angular.module('CodeQuestion').controller('CodeQuestionCtrl', [
    '$scope',
    CodeQuestionCtrl,
  ]);

  function CodeQuestionCtrl($scope) {
    // This is a function because we have multiple Ace's instances in the same page
    // If this is not a function, `onLoad` will always reference the last Ace instance
    $scope.ace_options = function (key, value) {
      return {
        useWrapMode : true,
        theme: 'twilight',
        mode: $scope.language || 'html',
        onLoad: function (ace) {
          ace.getSession().setTabSize(2);
          $scope[key] = value;

          $scope.changeLanguage = function () {
            ace.getSession().setMode("ace/mode/" + $scope.language);
          };
        },
      };
    }
  };

})(angular);
