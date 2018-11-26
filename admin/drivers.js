currentPoints = [];

function openTab(evt) {
    // Declare all variables
    var i, tablinks;

    tablinks = document.getElementsByClassName("tablinks");
    for (i = 0; i < tablinks.length; i++) {
        tablinks[i].className = tablinks[i].className.replace(" active", "");
    }

    evt.classList.add("active");
}


function makeDrivers(){
  for(i = 0; i < parent.JSONval.drivers.length; i++){
    main = document.getElementById("driverContent");
      card = document.createElement("div");
      card.setAttribute("class","card driver-card");
      card.setAttribute('onclick','displayItemOverlay();displayItem(this);loadAccount()');
        row = document.createElement("div");
        row.setAttribute("class","row no-gutters");
          imgDiv = document.createElement("div");
          imgDiv.setAttribute("class","col-auto");
          imgDiv.setAttribute("style","margin:4vh;margin-left:6vh");
            img = document.createElement("i");
            img.setAttribute("class","fa fa-user driver-pic");
            img.setAttribute("aria-hidden","true");
          contentDiv = document.createElement("div");
          contentDiv.setAttribute("class","col");
          contentDiv.setAttribute("style","position:relative;align-items:center;display:flex");
            nameP = document.createElement('p');
            nameP.setAttribute("class","card-text driver-title");
            nameP.innerHTML = parent.JSONval.drivers[i].drivers.driverName;
            valueIn = document.createElement('input');
            valueIn.setAttribute("style","text-align:right;width:15vh");
            valueIn.setAttribute("number","text");
            valueIn.setAttribute("value","0");
            valueIn.setAttribute("onclick","event.stopPropagation()");
            currentP = document.createElement('p');
            currentP.setAttribute("class","card-text driver-points");
            currentP.setAttribute("style","margin-left:4vh;margin-right:1vh");
            currentP.innerHTML = "Current Points: ";
            points = document.createElement('p');
            points.setAttribute("class","card-text driver-points");
            points.innerHTML = parent.JSONval.drivers[i].drivers.driverPoints;;
            currentPoints[i] = points.innerHTML;
            pointFin = document.createElement('p');
            pointFin.setAttribute("class","card-text driver-points");
            pointFin.setAttribute("style","margin-right:4vh;margin-left:1vh");
            pointFin.innerHTML = " Points";
            btn = document.createElement("button");
            btn.setAttribute("class","btn btn-primary driver-button");
            btn.setAttribute("onclick","subPoints(this);event.stopPropagation()");
            btn.innerHTML = "Subtract Points";
            btn2 = document.createElement("button");
            btn2.setAttribute("class","btn btn-primary driver-button");
            btn2.setAttribute("onclick","addPoints(this);event.stopPropagation()");
            btn2.innerHTML = "Add Points";
            password = document.createElement('p');
            password.setAttribute('style','display:none');
            password.innerHTML = parent.JSONval.drivers[i].drivers.driverPassword;


        contentDiv.appendChild(nameP);
        contentDiv.appendChild(valueIn);
        contentDiv.appendChild(btn2);
        contentDiv.appendChild(btn);
        contentDiv.appendChild(currentP);
        contentDiv.appendChild(points);
        contentDiv.appendChild(pointFin);
        contentDiv.appendChild(password);
        imgDiv.appendChild(img);
        row.appendChild(imgDiv);
        row.appendChild(contentDiv);
        card.appendChild(row);
        main.appendChild(card);
  }
}

function displayItemOverlay(){
  document.getElementById("itemOverlay").style.display = "block";
  document.getElementById("overlayContent").style.display = "block";
  document.documentElement.style.overflow = 'hidden';
  document.body.scroll = "no";
}

function displayItem(e){
  itemContent = document.getElementById('itemContent');
  overlayContent = document.getElementById('overlayContent');
  itemContent.innerHTML = e.innerHTML;
  itemContent.children[0].setAttribute("style","margin:4vh;margin-left:16vh");
  itemContent.children[0].children[1].children[1].remove();
  itemContent.children[0].children[1].children[1].remove();
  itemContent.children[0].children[1].children[1].remove();
  var numSpon = document.createElement('p');
  numSpon.setAttribute("class","card-text driver-title");
  numSpon.setAttribute("style","margin-right:1vh");
  numSpon.innerHTML = "Number of Sponsors: ";
  var sponNum = document.createElement('p');
  sponNum.setAttribute("class","card-text driver-title");
  sponNum.setAttribute("style","margin:0");
  sponNum.innerHTML = "2";

  itemContent.children[0].children[1].insertBefore(numSpon,itemContent.children[0].children[1].children[1]);
  itemContent.children[0].children[1].insertBefore(sponNum,itemContent.children[0].children[1].children[2]);
}

function closeItemOverlay(){
  document.getElementById("itemOverlay").style.display = "none";
  document.getElementById("overlayContent").style.display = "none";
  document.documentElement.style.overflow = 'scroll';
  document.body.scroll = "yes";
  openTab(document.getElementById("accountBtn"));
}

function addPoints(e){
  text = e.parentNode.children[5].textContent;
  val = e.parentNode.children[1].value;
  number = Number(text);
  box = Number(val);
  newNum = number + box;
  e.parentNode.children[5].innerHTML = newNum;
  e.parentNode.children[1].value = 0;
}

function subPoints(e){
  text = e.parentNode.children[5].textContent;
  val = e.parentNode.children[1].value;
  number = Number(text);
  box = Number(val);
  if(box > number){
    e.parentNode.children[1].value = 0;
    alert("Cannot set a driver negative");
  }
  else{
    newNum = number - box;
    e.parentNode.children[5].innerHTML = newNum;
    e.parentNode.children[1].value = 0;
  }
}

function cancelPoints(){
  cards = document.getElementById("mainDrivers").children[0].children;
  for( i = 0; i < cards.length; i++){
    cards[i].children[0].children[1].children[5].innerHTML = currentPoints[i];
  }
}

function submitPoints(){
  cards = document.getElementById("mainDrivers").children[0].children;
  for( i = 0; i < cards.length; i++){
    currentPoints[i] = cards[i].children[0].children[1].children[5].innerHTML;
  }
}

function loadAccount(){
  var driverContent = document.getElementById("driverOverlayContent");
  var itemContent = document.getElementById("itemContent");
  driverContent.innerHTML = "";
  curUser = document.createElement('p');
  user = document.createElement('input');
  curPass = document.createElement('p');
  pass = document.createElement('input');
  cancelBtn = document.createElement('button');
  removeBtn = document.createElement('button');
  updateBtn = document.createElement('button');

  cancelBtn.setAttribute('type','button');
  cancelBtn.setAttribute('class','btn btn-info sponsorProfileBtn');
  cancelBtn.setAttribute('style','top:40vh;padding-left:9vh;padding-right:9vh');
  cancelBtn.innerHTML = "Cancel Changes";
  removeBtn.setAttribute('type','button');
  removeBtn.setAttribute('class','btn btn-info sponsorProfileBtn');
  removeBtn.setAttribute('style','top:56vh');
  removeBtn.setAttribute('onclick','removePerm()');
  removeBtn.innerHTML = "Remove Driver";
  updateBtn.setAttribute('type','button');
  updateBtn.setAttribute('class','btn btn-info sponsorProfileBtn');
  updateBtn.setAttribute('style','top:48vh');
  updateBtn.innerHTML = "Update Profile";
  curUser.setAttribute("class","card-text driver-overlay-top");
  curUser.setAttribute("style","top:2vh");
  curUser.innerHTML = "Current User Name: ";
  user.setAttribute("class","driver-overlay-top");
  user.setAttribute("style","text-align:right;width:25vh;top:10vh");
  user.setAttribute("number","text");
  user.setAttribute("value",itemContent.children[0].children[1].children[0].innerHTML);
  curPass.setAttribute("class","card-text driver-overlay-top");
  curPass.setAttribute("style","top:22vh");
  curPass.innerHTML = "Current Password: ";
  pass.setAttribute("class","driver-overlay-top");
  pass.setAttribute("style","text-align:right;width:25vh;top:30vh");
  pass.setAttribute("number","text");
  pass.setAttribute("value",itemContent.children[0].children[1].children[6].innerHTML);

  driverContent.appendChild(cancelBtn);
  driverContent.appendChild(updateBtn);
  driverContent.appendChild(removeBtn);
  driverContent.appendChild(curPass);
  driverContent.appendChild(pass);
  driverContent.appendChild(curUser);
  driverContent.appendChild(user);

}

function removePerm() {
  var itemContent = document.getElementById("itemContent");
  var form2 = document.createElement("form");
  form2.action="http://server.isaacmcqueen.me:9615";
  form2.method="POST";
  var inpN = document.createElement("input");
  inpN.type="hidden";
  inpN.name="action";
  inpN.value="removePerm";
  form2.appendChild(inpN);
  var inpZ = document.createElement("input");
  inpZ.type="hidden";
  inpZ.name="username";
  inpZ.value=itemContent.children[0].children[1].children[0].innerHTML; 
  console.log(itemContent.children[0].children[1].children[0].innerHTML)
  form2.appendChild(inpZ);
  form2.submit();


}

function loadOrders(){
  var driverContent = document.getElementById("driverOverlayContent");
  var itemContent = document.getElementById("itemContent");
  driverContent.innerHTML = "";
}

function loadSponsorsAdmin(){
  var main = document.getElementById("driverOverlayContent");
  var itemContent = document.getElementById("itemContent");
  main.innerHTML = "";
  for(i = 1; i < 3; i++){
    card = document.createElement("div");
    card.setAttribute("class","card driver-card");
    // card.setAttribute("onclick","displayItemOverlay();displayItem(this);loadAccount()");
    card.setAttribute("style","width:90%")
      row = document.createElement("div");
      row.setAttribute("class","row no-gutters");
        imgDiv = document.createElement("div");
        imgDiv.setAttribute("class","col-auto");
        imgDiv.setAttribute("style","margin:4vh;margin-left:6vh");
          img = document.createElement("i");
          img.setAttribute("class","fa fa-user driver-pic");
          img.setAttribute("aria-hidden","true");
        contentDiv = document.createElement("div");
        contentDiv.setAttribute("class","col");
        contentDiv.setAttribute("style","position:relative;align-items:center;display:flex");
          nameP = document.createElement('p');
          nameP.setAttribute("class","card-text driver-title");
          nameP.innerHTML = "TestSp"+i;
          // currentP = document.createElement('p');
          // currentP.setAttribute("class","card-text driver-points");
          // currentP.setAttribute("style","margin-left:20vh;margin-right:1vh");
          // currentP.innerHTML = "Current Active Drivers: ";
          // drivers = document.createElement('p');
          // drivers.setAttribute("class","card-text driver-points");
          // drivers.innerHTML = "400";
          //currentPoints[i] = points.innerHTML;
          btn = document.createElement("button");
          btn.setAttribute("class","btn btn-primary driver-button");
          btn.setAttribute("onclick","event.stopPropagation()");
          btn.innerHTML = "Remove Sponsor";


      contentDiv.appendChild(nameP);
      // contentDiv.appendChild(currentP);
      // contentDiv.appendChild(drivers);
      contentDiv.appendChild(btn);
      imgDiv.appendChild(img);
      row.appendChild(imgDiv);
      row.appendChild(contentDiv);
      card.appendChild(row);
      main.appendChild(card);
    }
}
