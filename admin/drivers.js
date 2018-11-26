currentPoints = [];
startPoints = [];
currentName = [];

function openTab(evt) {
    // Declare all variables
    var i, tablinks;

    tablinks = document.getElementsByClassName("tablinks");
    for (i = 0; i < tablinks.length; i++) {
        tablinks[i].className = tablinks[i].className.replace(" active", "");
    }

    evt.classList.add("active");
}

function makeDrivers() {
  var xhttp = new XMLHttpRequest();
  xhttp.open("POST", "http://server.isaacmcqueen.me:9615/action", true);
  xhttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
  xhttp.onreadystatechange = function() {
    if (this.readyState == 4 && this.status == 200) {
      var val = JSON.parse(this.responseText);
      console.log(val);
      /*var inpR = document.createElement("input");
      inpR.type="hidden";
      inpR.name="accT";
      inpR.value="updatePoints";
      form1.appendChild(inpR);*/
      for(i=0;i<val.drivers.length;i++){
        startPoints[i] = val.drivers[i].points;
        var track = document.createElement("input");
        track.type="hidden";
        track.name="tr";
        track.value=i;
        /*var inpN = document.createElement("input");
        inpN.type="hidden";
        inpN.name="name";
        inpN.value=val.drivers[i].name;*/
        currentName[i] = val.drivers[i].name
        /*valueIn = document.createElement('input');
        valueIn.type="number";
        valueIn.name="points";
        valueIn.value=val.drivers[i].points;
        valueIn.style="text-align:right;width:15vh";*/
        /*value2 = document.createElement('input')
        value2.type="hidden";
        value2.name="sub";
        value2.value="pop"
        form1.appendChild(value2);
        /*document.getElementById("form1").appendChild(lbl);
        document.getElementById("form1").appendChild(inpN)
        document.getElementById("form1").appendChild(inpP);
        document.getElementById("form1").appendChild(document.createElement("br"));*/
        //form1.appendChild(inpN);
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
      /*var submit = document.createElement("button");
      submit.type="submit";
      submit.innerText="Update Points";
      form1.appendChild(submit);*/
      //main.appendChild(form1);
      //document.getElementById("form1").appendChild(submit);
    }
  };

  var obj = "action=driverPoints"
  xhttp.withCredentials = true;
  xhttp.send(obj);


}

/*function makeDrivers(){
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
}*/

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
  currentPoints[e.parentNode.children[7].value] = newNum;
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
    currentPoints[e.parentNode.children[7].value] = newNum;
  }
}

function cancelPoints(){
  cards = document.getElementById("mainDrivers").children[0].children;
  for( i = 0; i < cards.length; i++){
    cards[i].children[0].children[1].children[5].innerHTML = startPoints[i];
  }
}

function submitPoints(){
  /*cards = document.getElementById("mainDrivers").children[0].children;
  for( i = 0; i < cards.length; i++){
    currentPoints[i] = cards[i].children[0].children[1].children[5].innerHTML;
  }*/
  var form1 = document.createElement("form");
  form1.action="http://server.isaacmcqueen.me:9615";
  form1.method="POST";
  form1.id="form1";
  var inpR = document.createElement("input");
  inpR.type="hidden";
  inpR.name="accT";
  inpR.value="updatePoints";
  form1.appendChild(inpR);
  for(i=0;i<currentName.length;i++){
    var inpN = document.createElement("input");
    inpN.type="hidden";
    inpN.name="name";
    inpN.value=currentName[i];
    form1.appendChild(inpN);
    var inpP = document.createElement("input");
    inpP.type="hidden";
    inpP.name="points";
    inpP.value=currentPoints[i];
    form1.appendChild(inpP);
  }
  //document.getElementById("ContentDiv").appendChild(form1);
  form1.submit();
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
  var inpY = document.createElement("input");
  inpY.type="hidden";
  inpY.name="auth";
  inpY.value="driver";
  form2.appendChild(inpY);
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
