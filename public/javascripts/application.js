$(function() {
  $('#update-location-form input').blur(function(event) {
    $('#update-location-form').css('display', 'none');
    $('#update-location-link').css('display', 'inline');
  });
  $('#update-location-link').click(function(event){
    $(this).css('display', 'none');
    $('#update-location-form').css('display', 'inline');
    $('#update-location-form input').focus();
  
    event.preventDefault();
  });
});