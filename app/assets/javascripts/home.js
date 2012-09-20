$(function() {
  if('placeholder' in document.createElement('input')) {
    $("#session_email, #session_password").each(function(i, f) {
      var field = $(f);
      var label = $("label[for=" + field.attr('id') + "]");

      label.hide();
      field.attr('placeholder', label.text());
    });
  }
});