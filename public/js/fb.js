(function() {
  var Auth, namespace,
    __slice = [].slice;

  $('#connect').bind('click', function(e) {
    e.preventDefault();
    return Auth.login();
  });

  $('#connect-1').bind('click', function(e) {
    e.preventDefault();
    return Auth.login();
  });

  $('#logout').bind('click', function(e) {
    return Auth.logout();
  });

  Auth = (function() {
    function Auth() {}

    Auth.login = function() {
      return FB.login((function(response) {
        if (response.authResponse) {
          return window.location = '/auth/facebook/callback';
        }
      }), {
        scope: 'email'
      });
    };

    Auth.logout = function() {
      FB.getLoginStatus(function(response) {
        if (response.authResponse) {
          return FB.logout();
        }
      });
      return true;
    };

    return Auth;

  })();

  namespace = function(target, name, block) {
    var item, top, _i, _len, _ref, _ref1;
    if (arguments.length < 3) {
      _ref = [(typeof exports !== 'undefined' ? exports : window)].concat(__slice.call(arguments)), target = _ref[0], name = _ref[1], block = _ref[2];
    }
    top = target;
    _ref1 = name.split('.');
    for (_i = 0, _len = _ref1.length; _i < _len; _i++) {
      item = _ref1[_i];
      target = target[item] || (target[item] = {});
    }
    return block(target, top);
  };

  namespace("Cevility", function(exports) {
    return exports.Auth = Auth;
  });

}).call(this);
