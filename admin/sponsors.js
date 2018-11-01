function makeSponsors(){
  for(i = 0; i < 10; i++){
    main = document.getElementById("sponsorContent");
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
            nameP.innerHTML = "Sponsor "+i;
            currentP = document.createElement('p');
            currentP.setAttribute("class","card-text driver-points");
            currentP.setAttribute("style","margin-left:20vh;margin-right:1vh");
            currentP.innerHTML = "Current Active Drivers: ";
            drivers = document.createElement('p');
            drivers.setAttribute("class","card-text driver-points");
            drivers.innerHTML = "400";
            //currentPoints[i] = points.innerHTML;
            btn = document.createElement("button");
            btn.setAttribute("class","btn btn-primary driver-button");
            btn.setAttribute("onclick","subPoints(this)");
            btn.innerHTML = "Remove Sponsor";

        contentDiv.appendChild(nameP);
        contentDiv.appendChild(currentP);
        contentDiv.appendChild(drivers);
        contentDiv.appendChild(btn);
        imgDiv.appendChild(img);
        row.appendChild(imgDiv);
        row.appendChild(contentDiv);
        card.appendChild(row);
        main.appendChild(card);
  }
}
