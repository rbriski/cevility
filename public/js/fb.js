(function() {
  $('#connect').bind('click', (function(_this) {
    return function(e) {
      e.preventDefault();
      return FB.login((function(response) {
        if (response.authResponse) {
          return $.getJSON('/auth/facebook/callback', function(json) {
            console.log(JSON.stringify(json));
            return window.location.reload(true);
          });
        }
      }), {
        scope: 'email'
      });
    };
  })(this));

  $('#logout').bind('click', (function(_this) {
    return function(e) {
      e.preventDefault();
      return FB.logout(function(response) {
        if (response.authResponse) {
          return $.getJSON('/session/destroy', function(json) {
            console.log(JSON.stringify(json));
            return window.location.reload(true);
          });
        }
      });
    };
  })(this));

}).call(this);
