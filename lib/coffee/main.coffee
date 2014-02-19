class Auth

  @login: () ->
    console.log "Welcome! Fetching your info..."
    FB.api '/me', (response) ->
      console.log "Good to see you #{response.name}..."
      console.log response
