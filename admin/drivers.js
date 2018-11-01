currentPoints = [];

function makeDrivers(){
  for(i = 0; i < 10; i++){
    main = document.getElementById("driverContent");
      card = document.createElement("div");
      card.setAttribute("class","card driver-card");
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
            nameP.innerHTML = "Driver "+i;
            valueIn = document.createElement('input');
            valueIn.setAttribute("style","text-align:right;width:15vh");
            valueIn.setAttribute("number","text");
            valueIn.setAttribute("value","0");
            currentP = document.createElement('p');
            currentP.setAttribute("class","card-text driver-points");
            currentP.setAttribute("style","margin-left:4vh;margin-right:1vh");
            currentP.innerHTML = "Current Points: ";
            points = document.createElement('p');
            points.setAttribute("class","card-text driver-points");
            points.innerHTML = "2000";
            currentPoints[i] = points.innerHTML;
            pointFin = document.createElement('p');
            pointFin.setAttribute("class","card-text driver-points");
            pointFin.setAttribute("style","margin-right:4vh;margin-left:1vh");
            pointFin.innerHTML = " Points";
            btn = document.createElement("button");
            btn.setAttribute("class","btn btn-primary driver-button");
            btn.setAttribute("onclick","subPoints(this)");
            btn.innerHTML = "Subtract Points";
            btn2 = document.createElement("button");
            btn2.setAttribute("class","btn btn-primary driver-button");
            btn2.setAttribute("onclick","addPoints(this)");
            btn2.innerHTML = "Add Points";

        contentDiv.appendChild(nameP);
        contentDiv.appendChild(valueIn);
        contentDiv.appendChild(btn2);
        contentDiv.appendChild(btn);
        contentDiv.appendChild(currentP);
        contentDiv.appendChild(points);
        contentDiv.appendChild(pointFin);
        imgDiv.appendChild(img);
        row.appendChild(imgDiv);
        row.appendChild(contentDiv);
        card.appendChild(row);
        main.appendChild(card);
  }
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
