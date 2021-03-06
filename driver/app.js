// var itemIds = ["53039031","245232145","239112716","241067840","710163485"];
// var cartIds = ["53039031","239112716","710163485"];
// var orderIds = ["241067840","245232145"];

/* Set the width of the side navigation to 250px */
var JSONval={};

function openNav() {
    document.getElementById("mySidenav").style.width = "250px";
}

function loadMaster(){
  var xhttp = new XMLHttpRequest();
  xhttp.open("POST", "http://server.isaacmcqueen.me:9615/action", true);
  xhttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
  xhttp.onreadystatechange = function() {
    if (this.readyState == 4 && this.status == 200) {
      JSONval = JSON.parse(this.responseText);
      document.getElementById("driverName").innerHTML = JSONval.profile[0][0].driverName;
      document.getElementById("driverPoints").innerHTML = JSONval.points[0].points.driverPoints;
      document.getElementById("current-sponsor").innerHTML = "TestSp1";

      //document.getElementById("current-sponsor").innerHTML = JSONval.sponsors[0].sponsors.sponsorName;
      console.log(JSONval);
    }
  };

var obj = "action=masterDriver"
xhttp.withCredentials = true;
xhttp.send(obj);
setTimeout(loadCatalog,1000);
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

function loadOrders(){
  main = document.getElementById('main-content');
  frame = document.createElement('iframe');
  frame.setAttribute("id","iFrame");
  frame.setAttribute("src","orders.html");
  frame.setAttribute("height","100%");
  frame.setAttribute("width","100%");
  frame.setAttribute("frameBorder","0");
  main.appendChild(frame);
}

function loadCart(){
  main = document.getElementById('main-content');
  frame = document.createElement('iframe');
  frame.setAttribute("id","iFrame");
  frame.setAttribute("src","cart.html");
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
