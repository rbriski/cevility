(function() {
  $('#assign_license').bind('click', function(e) {
    var number;
    e.preventDefault();
    number = $('#assign_license').data('number');
    return $.post($('#assign_license').data('href'), function(data) {
      $('#login_license').html(data);
      return $('#alerts').html("<div class='alert alert-success alert-dismissable'> <button type='button' class='close' data-dismiss='alert' aria-hidden='true'>&times;</button> <strong>" + number + "</strong> is now assigned to you </div>");
    });
  });

}).call(this);
