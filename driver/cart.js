var itemIds = parent.cartIds;
var currentPrint = 0;

function makeCartMath(){
  var cartTotal = 0;
  main = document.getElementById("cartMath");
  currentPoints = document.createElement('p');
  currentPoints.setAttribute("class","card-text");
  currentPoints.setAttribute("style","font-size: 1.15rem;float:left;margin-left:6%;margin-top:15%;margin-right:14%")
  currentPoints.innerHTML = "Current Point Total:";
  points = document.createElement('p');
  points.setAttribute("class","card-text");
  points.setAttribute("style","font-size: 1.15rem;float:right;margin-right:8%;margin-top:15%;margin-left:10%")
  points.innerHTML = parent.JSONval.profile[0][0].driverPoints;

  main.appendChild(currentPoints);
  main.appendChild(points);

  for(j = 0; j < document.getElementById('cartContent').children.length; j++){
    curCart = document.getElementById('cartContent').children[j].children[0].children[1].children[2].innerHTML;
    curCartSplit = curCart.split(" ");
    curPoint = document.createElement("p");
    curPoint.setAttribute("class","card-text");
    curPoint.setAttribute("style","font-size: 1.15rem;float:right;margin-right:8%;margin-left:10%")
    curPoint.innerHTML = "";
    curPoint.innerHTML = curCartSplit[0];

    minus = document.createElement('p');
    minus.setAttribute("class","card-text");
    minus.setAttribute("style","font-size: 1.15rem;float:left;margin-left:45%;margin-right:14%");
    minus.innerHTML = "-";
    main.appendChild(minus);
    main.appendChild(curPoint);
    cartTotal = cartTotal + Number(curCartSplit[0]);
  }
  console.log(cartTotal);
  calcDiv = document.createElement("div");
  calcDiv.setAttribute("style","width:96%;height:15%;float:right;border-top: 1px solid black;");
  newPoint = document.createElement("p");
  newPoint.setAttribute("class","card-text");
  newPoint.setAttribute("style","font-size: 1.15rem;float:left;margin-left:3%;margin-top:5%;margin-right:14%")
  newPoint.innerHTML = "New Point Total:"
  actPoints = document.createElement("p");
  actPoints.setAttribute("class","card-text");
  actPoints.setAttribute("style","font-size: 1.15rem;float:right;margin-right:8%;margin-top:5%;margin-left:4%");
  actPoints.innerHTML = Number(window.parent.document.getElementById("driverPoints").innerHTML)-Number(cartTotal);
  calcDiv.appendChild(newPoint);
  calcDiv.appendChild(actPoints);
  main.appendChild(calcDiv);

  buttonDiv = document.createElement("div");
  buttonDiv.setAttribute("style","width:100%;height:25%;position:absolute;bottom:0");

  btnCheck = document.createElement("button");
  btnCheck.setAttribute("class","btn btn-primary");
  btnCheck.setAttribute("style","position:relative;left:25%;top:10%;width:50%");
  btnCheck.setAttribute("onclick","displayItemOverlay();displayItem(this.parentNode.parentNode.parentNode.children[0])");
  btnCheck.innerHTML = "Go to Checkout";

  btnRemove = document.createElement("button");
  btnRemove.setAttribute("class","btn btn-primary");
  btnRemove.setAttribute("style","position:absolute;bottom:25%;right:25%;width:50%")
  btnRemove.setAttribute("onclick","removeAllCart()");
  btnRemove.innerHTML = "Clear Entire Cart";

  buttonDiv.appendChild(btnCheck);
  buttonDiv.appendChild(btnRemove);
  main.appendChild(buttonDiv);
}

function runMath(e){
  if(e == itemIds.length){
    makeCartMath();
  }
}


// Create a JavaScript array of the item filters you want to use in your request
var filterarray = [
  {"name":"MaxPrice",
   "value":"100",
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


function makeCartItem(e){
  var currentItem = e.findItemsByProductResponse[0].searchResult[0].item[0];
  //console.log(currentItem);
  main = document.getElementById("cartContent");
    card = document.createElement("div");
    card.setAttribute("class","card order-card");
      row = document.createElement("div");
      row.setAttribute("class","row no-gutters");
        imgDiv = document.createElement("div");
        imgDiv.setAttribute("class","col-auto");
          img = document.createElement("img");
          img.setAttribute("class","mg-fluid");
          img.setAttribute("style","width:25vh;height:25vh");
          img.setAttribute("src",currentItem.galleryURL[0]);
        contentDiv = document.createElement("div");
        contentDiv.setAttribute("class","col");
        contentDiv.setAttribute("style","position:relative");
          divP = document.createElement('div');
          divP.setAttribute("style","width:50%; height:50%; word-break:break-all");
          divP.setAttribute("class","card-text order-title");
          divP.innerHTML = currentItem.title[0];
          statusP = document.createElement('p');
          statusP.setAttribute("class","card-text order-status");
          statusP.innerHTML = "Quanity: 1";
          points = document.createElement('p');
          points.setAttribute("class","card-text order-points");
          points.setAttribute("id","points"+i);
          points.innerHTML = Math.round(Number(currentItem.sellingStatus[0].currentPrice[0].__value__))*Number(parent.pV)+" Points";
          divBtn = document.createElement('div');
          divBtn.setAttribute("style","width:40%;height:50%;position:absolute;bottom:0;right:0;max-width:40%")
          btn = document.createElement("button");
          btn.setAttribute("class","btn btn-primary order-button");
          btn.setAttribute("style","position:relative;bottom:0;right:0;top:30%;width:100%");
          btn.setAttribute("onclick","removeFromCart(this)");
          btn.innerHTML = "Remove From Cart";
          itemId = document.createElement('p');
          itemId.setAttribute("style","display:none");
          itemId.innerHTML = currentItem.productId[0].__value__;

      divBtn.appendChild(btn);
      contentDiv.appendChild(divP);
      contentDiv.appendChild(statusP);
      contentDiv.appendChild(points);
      contentDiv.appendChild(divBtn);
      contentDiv.appendChild(itemId);
      imgDiv.appendChild(img);
      row.appendChild(imgDiv);
      row.appendChild(contentDiv);
      card.appendChild(row);
      main.appendChild(card);
      runMath(++currentPrint);
}


// Execute the function to build the URL filter
function getCartItem(e){
  buildURLArray(filterarray);
  var url = "http://svcs.ebay.com/services/search/FindingService/v1";
    url += "?OPERATION-NAME=findItemsByProduct";
    url += "&SERVICE-VERSION=1.0.0";
    url += "&SECURITY-APPNAME=Clemente-4910Grou-PRD-07f4c67ed-feea9193";
    url += "&GLOBAL-ID=EBAY-US";
    url += "&RESPONSE-DATA-FORMAT=JSON";
    url += "&callback=makeCartItem";
    url += "&REST-PAYLOAD";
    url += "&productId.@type=ReferenceID";
    url += "&productId="+e;
    url += "&paginationInput.entriesPerPage=1";
    url += urlfilter;


    // Submit the request
    s=document.createElement('script'); // create script element
    s.src= url;
    document.body.appendChild(s);
}

function makeCart(){
  for(i = 0;i < itemIds.length; i++){
    getCartItem(itemIds[i]);
  }
}

function removeFromCart(e){
  var index = parent.cartIds.indexOf(e.parentNode.parentNode.children[4].innerHTML);
  if (index > -1){
    parent.cartIds.splice(index,1);
    location.reload();
  }
}

function removeAllCart(){
  parent.cartIds = [];
  location.reload();
}

function displayItemOverlay(){
  document.getElementById("itemOverlay").style.display = "block";
  document.getElementById("overlayContent").style.display = "block";
  document.documentElement.style.overflow = 'hidden';
  document.body.scroll = "no";
}

function displayItem(e){
  itemContent = document.getElementById('itemContent');
  for( i = 0; i < e.children.length; i++){
    var singleItem = document.createElement('div');
    singleItem.setAttribute("class","card order-card");
    singleItem.innerHTML = e.children[i].innerHTML;
    singleItem.children[0].children[1].children[3].remove();
    itemContent.appendChild(singleItem);
  }
}

function closeItemOverlay(){
  document.getElementById("itemOverlay").style.display = "none";
  document.getElementById("overlayContent").style.display = "none";
  document.documentElement.style.overflow = 'scroll';
  itemContent = document.getElementById('itemContent');
  itemContent.innerHTML = "";
  document.body.scroll = "yes";
}

function finishCheckout(){
  var orderIds = parent.orderIds;
  itemContent = document.getElementById('itemContent');
  for(i = 0; i < itemContent.children.length; i++){
    orderIds.push(itemContent.children[i].children[0].children[1].children[3].innerHTML);
  }
  removeAllCart();
}

function cancelCheckout(){
  itemContent = document.getElementById('itemContent');
  itemContent.innerHTML = "";
  closeItemOverlay();
}
