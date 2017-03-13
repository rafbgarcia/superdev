/**
 * Used in:
 * - views/application/_footer_registered_user
 *
 * View params:
 * @param Object user_level {
 *   level: Integer,
 *   xp: Ingeter,
 *   next_level_needed_xp: Integer,
 * }
 */

(function (angular) {

  angular.module('User').controller('UserLevelCtrl', [
    '$rootScope', 'User', 'user_level',
    UserLevelCtrl
  ]);

  function UserLevelCtrl($rootScope, User, user_level) {
    User.update_level(user_level);
    $rootScope.user = User;
  }

})(angular);
