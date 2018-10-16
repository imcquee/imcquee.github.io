function openCity(evt, cityName) {
    // Declare all variables
    var i, tabcontent, tablinks;

    // Get all elements with class="tabcontent" and hide them
    tabcontent = document.getElementsByClassName("tabcontent");
    for (i = 0; i < tabcontent.length; i++) {
        tabcontent[i].style.display = "none";
    }

    // Get all elements with class="tablinks" and remove the class "active"
    tablinks = document.getElementsByClassName("tablinks");
    for (i = 0; i < tablinks.length; i++) {
        tablinks[i].className = tablinks[i].className.replace(" active", "");
    }

    // Show the current tab, and add an "active" class to the link that opened the tab
    document.getElementById(cityName).style.display = "block";
    evt.currentTarget.className += " active";
}

function makeOrders(){
  for(i = 0; i < 10; i++){
    main = document.getElementById("orderContent");
      card = document.createElement("div");
      card.setAttribute("class","card order-card");
        row = document.createElement("div");
        row.setAttribute("class","row no-gutters");
          imgDiv = document.createElement("div");
          imgDiv.setAttribute("class","col-auto");
            img = document.createElement("img");
            img.setAttribute("src","product_1_pic.png");
            img.setAttribute("class","mg-fluid");
          contentDiv = document.createElement("div");
          contentDiv.setAttribute("class","col");
          contentDiv.setAttribute("style","position:relative");
            nameP = document.createElement('p');
            nameP.setAttribute("class","card-text order-title");
            nameP.innerHTML = "Missha All Around Safe Block Sebum Zero Sun";
            statusP = document.createElement('p');
            statusP.setAttribute("class","card-text order-status");
            statusP.innerHTML = "Status: Shipped";
            points = document.createElement('p');
            points.setAttribute("class","card-text order-points");
            points.innerHTML = "2,000 Points";
            btn = document.createElement("button");
            btn.setAttribute("class","btn btn-primary order-button");
            btn.innerHTML = "Cancel Order";

        contentDiv.appendChild(nameP);
        contentDiv.appendChild(statusP);
        contentDiv.appendChild(points);
        contentDiv.appendChild(btn);
        imgDiv.appendChild(img);
        row.appendChild(imgDiv);
        row.appendChild(contentDiv);
        card.appendChild(row);
        main.appendChild(card);
  }
}
