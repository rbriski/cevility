$('#about-header').click( ->
  $('html, body').animate
    scrollTop: $('#top-of-about').offset().top,
    700
)

$('#assign_license').bind 'click', (e) ->
  e.preventDefault()

  number = $('#assign_license').data('number')
  $.post($('#assign_license').data('href'), (data) ->
    $('#login_license').html(data)
    $('#alerts').html("
      <div class='alert alert-success alert-dismissable'>
        <button type='button' class='close' data-dismiss='alert' aria-hidden='true'>&times;</button>
        <strong>" + number + "</strong> is now assigned to you
      </div>")
  )

