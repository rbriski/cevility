var Auth;

Auth = (function() {
  function Auth() {}

  Auth.login = function() {
    console.log("Welcome! Fetching your info...");
    return FB.api('/me', function(response) {
      console.log("Good to see you " + response.name + "...");
      return console.log(response);
    });
  };

  return Auth;

})();
