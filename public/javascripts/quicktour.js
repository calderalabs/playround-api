var Quicktour = {
  path: null,
  
  initialize: function(options) {
    var self = this;

    $.each(options.guiders, function(index, guider) {
      buttons = [];

      if(guider.next)
        buttons.push({ name: guider.next, onclick: function() { self.next(); }});
      if(guider.close)
        buttons.push({ name: guider.close, onclick: function() { self.close(); }});

      guiders.createGuider({
        title: guider.title,
        buttons: buttons,
        description: guider.description,
        overlay: guider.overlay,
        attachTo: guider.attach ? '#' + guider.attach : null,
        position: guider.attach ? 6 : 0,
        id: 'guider_' + index,
        next: (index == options.guiders.length) ? null : 'guider_' + (index + 1)
      });
    });
    
    self.path = options.path;
  },
  
  close: function() {
    guiders.hideAll();

    $.ajax({
      type: "DELETE",
      url: this.path,
      contentType: 'application/json'
    });
  },

  next: function() {
    $.ajax({
      type: "PUT",
      url: this.path,
      contentType: 'application/json'
    });

    guiders.next();
  },

  show: function(index) {
    guiders.show('guider_' + index);
  }
};