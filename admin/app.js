
// var itemIds = ["53039031","245232145","239112716","241067840","710163485"];
// var cartIds = ["53039031","239112716","710163485"];
// var orderIds = ["241067840","245232145"];
var JSONval={};

function loadMaster() {
  var xhttp = new XMLHttpRequest();
  xhttp.open("POST", "http://server.isaacmcqueen.me:9615/action", true);
  xhttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
  xhttp.onreadystatechange = function() {
    if (this.readyState == 4 && this.status == 200) {
      JSONval = JSON.parse(this.responseText);
      console.log(JSONval);
      document.getElementById('adminName').innerHTML = JSONval.profile[0][0].adminName;
    }
  };

var obj = "action=masterAdmin"
xhttp.withCredentials = true;
xhttp.send(obj);
setTimeout(loadSponsors,1000);
}

// var xhttp = new XMLHttpRequest();
// xhttp.open("POST", "http://server.isaacmcqueen.me:9615/action", true);
// xhttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
// //xhttp.setRequestHeader("Cookie", );
// xhttp.onreadystatechange = function() {
//   if (this.readyState == 4 && this.status == 200) {
//     var val = JSON.parse(this.responseText);
//     document.getElementById('adminName').innerHTML = val.username;
//   }
// };
// var obj = "action=profile"
// xhttp.withCredentials = true;
// xhttp.send(obj);

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

function loadSponsors(){
  main = document.getElementById('main-content');
  frame = document.createElement('iframe');
  frame.setAttribute("id","iFrame");
  frame.setAttribute("src","sponsors.html");
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

function loadCart(){
  // main = document.getElementById('main-content');
  // frame = document.createElement('iframe');
  // frame.setAttribute("id","iFrame");
  // frame.setAttribute("src","cart.html");
  // frame.setAttribute("height","100%");
  // frame.setAttribute("width","100%");
  // frame.setAttribute("frameBorder","0");
  // main.appendChild(frame);
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
