$('#connect').bind 'click', (e) =>
  e.preventDefault()

  FB.login( ((response) ->
    if response.authResponse
      $.getJSON('/auth/facebook/callback', (json) ->
        console.log JSON.stringify(json)
        window.location.reload true
      )
  ), {scope: 'email'})

$('#logout').bind 'click', (e) =>
  e.preventDefault()

  FB.logout( (response) ->
    if response.authResponse
      $.getJSON('/session/destroy', (json) ->
        console.log JSON.stringify(json)
        window.location.reload true
      )
  )