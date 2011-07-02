function closeQuickTour() {
  guiders.hideAll();
  
  $.ajax({
    type: "PUT",
    url: '/settings',
    contentType: 'application/json',
    data: JSON.stringify({
      settings: { show_quicktour: false }
    })
  });
}

function updateCurrentGuider(guider) {
  $.ajax({
    type: "PUT",
    url: '/settings',
    contentType: 'application/json',
    data: JSON.stringify({
      settings: { current_guider: guider['id'] }
    })
  });
}

$(function() {
  guiders.createGuider({
    buttons: [{name: "Next"}, {name: "No, thanks", onclick: closeQuickTour }],
    description: "This is your first time signing in Playround. Click next to begin a quick tour showing you what is this all about.",
    id: "welcome",
    next: "location",
    overlay: true,
    title: "Welcome to Playround!",
    onShow: updateCurrentGuider
  })
  
  guiders.createGuider({
    attachTo: "#change-location",
    buttons: [{name: "Next"}],
    description: "The first thing to do, if it is not correct, is to change your current city by clicking this label. Just enter the city you live in in the box that appears to you.",
    id: "location",
    next: "profile",
    position: 6,
    title: "Change your location",
    onShow: updateCurrentGuider
  })
  
  guiders.createGuider({
    attachTo: "#change-profile",
    buttons: [{name: "Next"}],
    description: "Here you can fill some informations about you. This will help others to know a little more about who you are. It is strongly reccomended to put your list of favorite games to improve your Playround experience.",
    id: "profile",
    next: "rounds",
    position: 6,
    title: "Change profile",
    onShow: updateCurrentGuider
  })
  
  guiders.createGuider({
    attachTo: "#rounds-nav",
    buttons: [{name: "Next"}],
    description: "This section will show you the list of rounds around you. Rounds are matches organized by users or public places that will allow you to meet new people while playing games together. Every round is associated to a real place, or arena, and they're not meant to organize online matches.",
    id: "rounds",
    next: "arenas",
    position: 6,
    title: "What are rounds?",
    onShow: updateCurrentGuider
  })
  
  guiders.createGuider({
    attachTo: "#arenas-nav",
    buttons: [{name: "Close", onclick: closeQuickTour }],
    description: "This section will show you the list of arenas around you. Arenas are public places in which you can organize your matches. You can also create your own private arena that will be available only for the rounds you organize.",
    id: "arenas",
    position: 6,
    title: "What are arenas?",
    onShow: updateCurrentGuider
  })
});