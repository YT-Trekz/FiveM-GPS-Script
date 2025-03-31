function closegos() {
    document.getElementById("gps-screen").style.display = "none";
    document.getElementById("tomtombeeld").style.display = "none";
}

document.onkeyup = function (data) {
  if (data.which == 27) { // Escape-toets
    $.post(`https://${GetParentResourceName()}/closegps`, JSON.stringify({}));
    closegos();
    return;
  }
};

window.addEventListener('message', function(event) {
    if (event.data.action === 'OpenGps') {   
      document.getElementById("gps-screen").style.display = "block";
      document.getElementById("tomtombeeld").style.display = "block";
    }
});
//
document.getElementById('gps-player').addEventListener('keypress' , function  (e) {
    if (e.key === 'Enter') {
        let playerId = document.getElementById('gps-player').value;
        if (playerId) {
            $.post(`https://${GetParentResourceName()}/GpsPingPlayer`, JSON.stringify({ playerId: playerId }));
            closegos();
        }
    }
});

document.getElementById('gps-map').addEventListener('keypress', function(e) {
  if (e.key === 'Enter') {
      let postalCode = document.getElementById('gps-map').value;  // Gebruik postcode in plaats van playerId
      if (postalCode) {
          $.post(`https://${GetParentResourceName()}/GpsPingMap`, JSON.stringify({ postalCode: postalCode }));
          closegos();
      }
  }
});
