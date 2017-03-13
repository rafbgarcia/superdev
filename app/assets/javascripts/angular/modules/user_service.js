/**
 * Singleton User class
 * Used to share Current User's information across controllers
 */

(function (angular) {

  angular.module('SuperDev').service('User', [
    '$rootScope',
    UserService
  ]);

  function UserService($rootScope) {
    var self = this;
    set_defaults();

    self.update_level = function(user_level) {
      update_attributes(user_level);
      // if (user_has_leveled_up(user_level)) {
      //   animate_level_up(user_level);
      // } else {
      //   update_attributes(user_level);
      // }
    };

    function update_attributes(user) {
      _.each(user, function (val, key) {
        if (key === 'xp') {
          self.xp = typeof(user.xp) === 'number' ? user.xp : self.xp;
        } else {
          self[key] = val || self[key];
        }
      });

      self.percent_of_xp = calculate_xp_percent()
    }

    function calculate_xp_percent() {
      var percent = (self.xp / self.next_level_needed_xp) * 100;

      if (percent === NaN) {
        return self.percent_of_xp;
      }
      return percent.toFixed(2);
    }

    function set_defaults() {
      self.level = null;
      self.xp = null;
      self.percent_of_xp = null;
      self.next_level_needed_xp = null;
      self.answers_count = 0;
      self.correct_answers_count = 0;
    }

    // function animate_level_up(user) {
    //   var css_transition_duration = 400;

    //   update_attributes({xp: self.next_level_needed_xp})

    //   window.setTimeout(function () {
    //     $('#js_progressbar').hide(0);
    //     update_attributes({xp: 0, level: user.level});
    //     $rootScope.$apply();

    //     window.setTimeout(function () {
    //       $('#js_progressbar').show(0);
    //       update_attributes(user);
    //       $rootScope.$apply();
    //     }, css_transition_duration);
    //   }, css_transition_duration);
    // }

    // function user_has_leveled_up(user) {
    //   if (!(user && user.level) || !self.level) {
    //     return false;
    //   }
    //   return user.level > self.level
    // }
  }

})(angular);
