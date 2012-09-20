//= require jquery
//= require jquery_ujs
//= require jquery.tokeninput
//= require bootstrap
//= require bootstrap-timepicker
//= require bootstrap-datepicker
//= require_self
//= require_tree .

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