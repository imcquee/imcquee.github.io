//var itemIds = ["53039031","245232145","239112716","241067840","710163485"];

var JSONval={};

// var xhttp = new XMLHttpRequest();
// xhttp.open("POST", "http://server.isaacmcqueen.me:9615/action", true);
// xhttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
// //xhttp.setRequestHeader("Cookie", );
// xhttp.onreadystatechange = function() {
//   if (this.readyState == 4 && this.status == 200) {
//     var val = JSON.parse(this.responseText);
//     document.getElementById('sponsorName').innerHTML = val.username;
//   }
// };
// var obj = "action=profile"
// xhttp.withCredentials = true;
// xhttp.send(obj);
//
// var xhttp = new XMLHttpRequest();
// xhttp.open("POST", "http://server.isaacmcqueen.me:9615/action", true);
// xhttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
// //xhttp.setRequestHeader("Cookie", );
// xhttp.onreadystatechange = function() {
//   if (this.readyState == 4 && this.status == 200) {
//     var val = JSON.parse(this.responseText);
//     document.getElementById('current-driver-amount').innerHTML = val.drivers.length;
//   }
// };
// var obj = "action=driverPoints"
// xhttp.withCredentials = true;
// xhttp.send(obj);

function loadMaster(){
  var xhttp = new XMLHttpRequest();
  xhttp.open("POST", "http://server.isaacmcqueen.me:9615/action", true);
  xhttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
  xhttp.onreadystatechange = function() {
    if (this.readyState == 4 && this.status == 200) {
      JSONval = JSON.parse(this.responseText);
      document.getElementById('current-driver-amount').innerHTML = JSONval.drivers.length;
      document.getElementById('sponsorName').innerHTML = JSONval.profile[0][0].sponsorName;
      console.log(JSONval);
    }
  };

  var obj = "action=masterSponsor"
  xhttp.withCredentials = true;
  xhttp.send(obj);
  setTimeout(loadDrivers,1000);
}


/* Set the width of the side navigation to 250px */
function openNav() {
    document.getElementById("mySidenav").style.width = "250px";
}

/* Set the width of the side navigation to 0 */
function closeNav() {
    document.getElementById("mySidenav").style.width = "0";
}

function clearFrame(){
  main = document.getElementById('main-content');
  main.removeChild(document.getElementById("iFrame"));
}

function loadCatalog(){
  main = document.getElementById('main-content');
  frame = document.createElement('iframe');
  frame.setAttribute("id","iFrame");
  frame.setAttribute("src","catalog.html");
  frame.setAttribute("height","100%");
  frame.setAttribute("width","100%");
  frame.setAttribute("frameBorder","0");
  main.appendChild(frame);
}

function loadDrivers(){
  main = document.getElementById('main-content');
  frame = document.createElement('iframe');
  frame.setAttribute("id","iFrame");
  frame.setAttribute("src","drivers.html");
  frame.setAttribute("height","100%");
  frame.setAttribute("width","100%");
  frame.setAttribute("frameBorder","0");
  main.appendChild(frame);
}

function loadProfile() {
  main = document.getElementById('main-content');
  frame = document.createElement('iframe');
  frame.setAttribute("id","iFrame");
  frame.setAttribute("src","profile.html");
  frame.setAttribute("height","100%");
  frame.setAttribute("width","100%");
  frame.setAttribute("frameBorder","0");
  main.appendChild(frame);
}
