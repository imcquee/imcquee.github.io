var itemIds = parent.itemIds;
//var JSONval = parent.JSONval;

// Create a JavaScript array of the item filters you want to use in your request
var filterarray = [
  {"name":"MaxPrice",
   "value":"1000",
   "paramName":"Currency",
   "paramValue":"USD"},
  {"name":"FreeShippingOnly",
   "value":"true",
   "paramName":"",
   "paramValue":""},
  {"name":"ListingType",
   "value":["AuctionWithBIN", "FixedPrice", "StoreInventory"],
   "paramName":"",
   "paramValue":""},
  ];

// Define global variable for the URL filter
var urlfilter = "";

// Generates an indexed URL snippet from the array of item filters
function  buildURLArray() {
  // Iterate through each filter in the array
  for(var i=0; i<filterarray.length; i++) {
    //Index each item filter in filterarray
    var itemfilter = filterarray[i];
    // Iterate through each parameter in each item filter
    for(var index in itemfilter) {
      // Check to see if the paramter has a value (some don't)
      if (itemfilter[index] !== "") {
        if (itemfilter[index] instanceof Array) {
          for(var r=0; r<itemfilter[index].length; r++) {
          var value = itemfilter[index][r];
          urlfilter += "&itemFilter\(" + i + "\)." + index + "\(" + r + "\)=" + value ;
          }
        }
        else {
          urlfilter += "&itemFilter\(" + i + "\)." + index + "=" + itemfilter[index];
        }
      }
    }
  }
}  // End buildURLArray() function

function makeCatalogItem(e){
  var currentItem = e.findItemsByProductResponse[0].searchResult[0].item[0];
  main = document.getElementById("driverOverlayContent");
  cardDiv = document.createElement("div");
  card = document.createElement("div");
    img = document.createElement("img");
    cardBody = document.createElement("div");
      h5 = document.createElement("h5");
      p = document.createElement("p");
      butn = document.createElement("button");

  cardDiv.setAttribute("onclick","displayItemOverlayProduct();displayItemProduct(this)");
  card.setAttribute("class","card catalog-card");
    img.setAttribute("class","card-img-top");
    img.setAttribute("style","width:25vh;height:25vh;margin:0 auto; display:block");
    img.setAttribute("src",currentItem.galleryURL[0]);
    cardBody.setAttribute("class","card-body");
    cardBody.setAttribute("style","text-align:center");
    h5Div = document.createElement('div');
    h5Div.setAttribute("style","width:100%;height:15vh");
      h5.setAttribute("class","card-title");
      h5.setAttribute("style","margin:auto;padding-bottom:1vh");
      p.setAttribute("class","card-text");
      p.setAttribute("style",style="margin:auto;padding-bottom:1vh");
      butn.setAttribute("class","btn btn-primary");
      butn.setAttribute("style","margin:auto;width:60%");
      butn.setAttribute("onclick","event.stopPropagation();removeFromCatalog(this)");

      h5.innerHTML = currentItem.title[0];
      p.innerHTML = currentItem.sellingStatus[0].currentPrice[0].__value__;
      butn.innerHTML = "Remove";

      h5Div.appendChild(h5);
      cardBody.appendChild(h5Div);
      cardBody.appendChild(p);
      cardBody.appendChild(butn);
      card.appendChild(img);
      card.appendChild(cardBody);
      cardDiv.appendChild(card);
      main.appendChild(cardDiv);
}

// Execute the function to build the URL filter
function getCatalogItem(e){
  buildURLArray(filterarray);
  var url = "http://svcs.ebay.com/services/search/FindingService/v1";
    url += "?OPERATION-NAME=findItemsByProduct";
    url += "&SERVICE-VERSION=1.0.0";
    url += "&SECURITY-APPNAME=Clemente-4910Grou-PRD-07f4c67ed-feea9193";
    url += "&GLOBAL-ID=EBAY-US";
    url += "&RESPONSE-DATA-FORMAT=JSON";
    url += "&callback=makeCatalogItem";
    url += "&REST-PAYLOAD";
    url += "&productId.@type=ReferenceID";
    url += "&productId="+e;
    url += "&paginationInput.entriesPerPage=3";
    url += urlfilter;


    // Submit the request
    s=document.createElement('script'); // create script element
    s.src= url;
    document.body.appendChild(s);
}

function openTab(evt) {
    // Declare all variables
    var i, tablinks;

    tablinks = document.getElementsByClassName("tablinks");
    for (i = 0; i < tablinks.length; i++) {
        tablinks[i].className = tablinks[i].className.replace(" active", "");
    }

    evt.classList.add("active");
}

function makeSponsors(){
  console.log(parent.JSONval.sponsors.length);
  for(i = 0; i < parent.JSONval.sponsors.length; i++){
    main = document.getElementById("sponsorContent");
      card = document.createElement("div");
      card.setAttribute("class","card driver-card");
      card.setAttribute("onclick","displayItemOverlay();displayItem(this);loadAccount()");
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
            nameP.innerHTML = parent.JSONval.sponsors[i].sponsors.sponsorName;
            currentP = document.createElement('p');
            currentP.setAttribute("class","card-text driver-points");
            currentP.setAttribute("style","margin-left:20vh;margin-right:1vh");
            currentP.innerHTML = "Current Active Drivers: ";
            drivers = document.createElement('p');
            drivers.setAttribute("class","card-text driver-points");
            drivers.innerHTML = "400";
            password = document.createElement('p');
            password.setAttribute('style','display:none');
            password.innerHTML = parent.JSONval.sponsors[i].sponsors.sponsorPassword;
            //currentPoints[i] = points.innerHTML;
            // btn = document.createElement("button");
            // btn.setAttribute("class","btn btn-primary driver-button");
            // btn.setAttribute("onclick","event.stopPropagation()");
            // btn.innerHTML = "Remove Sponsor";


        contentDiv.appendChild(nameP);
        contentDiv.appendChild(currentP);
        contentDiv.appendChild(drivers);
        contentDiv.appendChild(password);
        // contentDiv.appendChild(btn);
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

function displayItemOverlayProduct(){
  document.getElementById("itemOverlayProduct").style.display = "block";
  document.getElementById("overlayContentProduct").style.display = "block";
  document.documentElement.style.overflow = 'hidden';
  document.body.scroll = "no";
}

function displayItemProduct(e){
  itemContent = document.getElementById('itemContentProduct');
  overlayContent = document.getElementById('overlayContentProduct');
  itemContent.innerHTML = e.innerHTML;
  itemContent.children[0].children[0].setAttribute("style","width:25vh;height:25vh;margin-left:0");
  itemContent.children[0].setAttribute("style","margin-top:9%;margin-left:5.5%;margin-right:2.5%");
}

function displayItem(e){
  itemContent = document.getElementById('itemContent');
  overlayContent = document.getElementById('overlayContent');
  itemContent.innerHTML = e.innerHTML;
  itemContent.children[0].setAttribute("style","margin:4vh;margin-left:16vh");
  // itemContent.children[0].children[1].children[3].remove();
}

function closeItemOverlayProduct() {
  document.getElementById("itemOverlayProduct").style.display = "none";
  document.getElementById("overlayContentProduct").style.display = "none";
  document.documentElement.style.overflow = 'scroll';
  document.body.scroll = "yes";
}

function closeItemOverlay(){
  document.getElementById("itemOverlay").style.display = "none";
  document.getElementById("overlayContent").style.display = "none";
  document.documentElement.style.overflow = 'scroll';
  document.body.scroll = "yes";
  openTab(document.getElementById("accountBtn"));
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
  removeBtn.setAttribute('style','top:56vh;padding-left:9vh;padding-right:9vh');
  removeBtn.innerHTML = "Remove Sponsor";
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
  pass.setAttribute("value","cpsc4910");
  console.log(itemContent);

  driverContent.appendChild(cancelBtn);
  driverContent.appendChild(updateBtn);
  driverContent.appendChild(removeBtn);
  driverContent.appendChild(curPass);
  driverContent.appendChild(pass);
  driverContent.appendChild(curUser);
  driverContent.appendChild(user);

}

function loadCatalog(){
  var driverContent = document.getElementById("driverOverlayContent");
  var itemContent = document.getElementById("itemContent");
  driverContent.innerHTML = "";
  for(i = 0; i < itemIds.length; i++){
    getCatalogItem(itemIds[i]);
  }
  var addBtn = document.createElement('button');
  var icon = document.createElement('i');
  icon.setAttribute('class','fa fa-plus-circle');
  icon.setAttribute('aria-hidden','true');
  icon.setAttribute('style','font-size:7vh');
  addBtn.setAttribute('type','button');
  addBtn.setAttribute('class','btn btn-info productAddBtn');
  addBtn.setAttribute('onclick','openAdd()');
  addBtn.appendChild(icon);
  driverContent.appendChild(addBtn);
}

function openAdd() {
  document.getElementById("addOverlay").style.display = "block";
  document.getElementById("addContent").style.display = "block";
  document.documentElement.style.overflow = 'hidden';
  document.body.scroll = "no";
}

function closeAddOverlay() {
  document.getElementById("addOverlay").style.display = "none";
  document.getElementById("addContent").style.display = "none";
  document.documentElement.style.overflow = 'scroll';
  document.body.scroll = "yes";
  document.getElementById("itemToAdd").value = "";
}

function addToCatalog(){
  console.log(document.getElementById("itemToAdd").value);
  document.getElementById("itemToAdd").value = "";
}
