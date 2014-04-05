$('#connect').bind 'click', (e) ->
  e.preventDefault()

  Auth.login()

$('#connect-1').bind 'click', (e) ->
  e.preventDefault()

  Auth.login()

$('#logout').bind 'click', (e) ->
  Auth.logout()

class Auth
  @login: ->
    FB.login ( (response) ->
      window.location = '/auth/facebook/callback' if response.authResponse
    ), {scope: 'email'}

  @logout: ->
    FB.getLoginStatus (response) ->
      FB.logout() if response.authResponse
    true


namespace = (target, name, block) ->
  [target, name, block] = [(if typeof exports isnt 'undefined' then exports else window), arguments...] if arguments.length < 3
  top    = target
  target = target[item] or= {} for item in name.split '.'
  block target, top

namespace "Cevility", (exports) ->
  exports.Auth = Auth

