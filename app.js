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
  document.getElementById('main-content').src = "http://isaacmcqueen.me/catalog.js";
  frame = document.createElement('iframe');
  frame.setAttribute("id","iFrame");
  //frame.setAttribute("src","http://isaacmcqueen.me/catalog.js");
  frame.setAttribute("height","100%");
  frame.setAttribute("width","100%");
  frame.setAttribute("frameBorder","0");
  main.appendChild(frame);
}

function loadOrders(){
  main = document.getElementById('main-content');
  frame = document.createElement('iframe');
  frame.setAttribute("id","iFrame");
  frame.setAttribute("src","http://isaacmcqueen.me/orders.js");
  frame.setAttribute("height","100%");
  frame.setAttribute("width","100%");
  frame.setAttribute("frameBorder","0");
  main.appendChild(frame);
}
