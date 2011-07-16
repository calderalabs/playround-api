function closeQuicktour() {
  guiders.hideAll();
  
  $.ajax({
    type: "DELETE",
    url: quicktour_path,
    contentType: 'application/json'
  });
}

function nextGuider(guider) {
  $.ajax({
    type: "PUT",
    url: quicktour_path,
    contentType: 'application/json'
  });
  
  guiders.next();
}

$(function() {
  guiders.createGuider({
    buttons: [{name: "Next", onclick: nextGuider }, {name: "No, thanks", onclick: closeQuicktour }],
    description: "This is your first time signing in Playround. Click next to begin a quick tour showing you what is this all about.",
    id: available_guiders[0],
    next: available_guiders[1],
    overlay: true,
    title: "Welcome to Playround!"
  });

  guiders.createGuider({
    attachTo: "#change-location",
    buttons: [{name: "Next", onclick: nextGuider }],
    description: "The first thing to do, if it is not correct, is to change your current city by clicking this label. Just enter the city you live in in the box that appears to you.",
    id: available_guiders[1],
    next: available_guiders[2],
    position: 6,
    title: "Change your location"
  });

  guiders.createGuider({
    attachTo: "#change-profile",
    buttons: [{name: "Next", onclick: nextGuider}],
    description: "Here you can fill some informations about you. This will help others to know a little more about who you are. It is strongly reccomended to put your list of favorite games to improve your Playround experience.",
    id: available_guiders[2],
    next: available_guiders[3],
    position: 6,
    title: "Change profile"
  });

  guiders.createGuider({
    attachTo: "#rounds-nav",
    buttons: [{name: "Next", onclick: nextGuider}],
    description: "This section will show you the list of rounds around you. Rounds are matches organized by users or public places that will allow you to meet new people while playing games together. Every round is associated to a real place, or arena, and they're not meant to organize online matches.",
    id: available_guiders[3],
    next: available_guiders[4],
    position: 6,
    title: "What are rounds?"
  });

  guiders.createGuider({
    attachTo: "#arenas-nav",
    buttons: [{name: "Close", onclick: closeQuicktour }],
    description: "This section will show you the list of arenas around you. Arenas are public places in which you can organize your matches. You can also create your own private arena that will be available only for the rounds you organize.",
    id: available_guiders[4],
    position: 6,
    title: "What are arenas?"
  });
  
  guiders.show(current_guider);
});