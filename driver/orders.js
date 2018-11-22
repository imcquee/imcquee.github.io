var itemIds = parent.orderIds;
var cancelIds = parent.cancelIds;
var runningCancel = false;

console.log(parent.JSONval);
function openTab(evt) {
    // Declare all variables
    var i, tablinks;

    tablinks = document.getElementsByClassName("tablinks");
    for (i = 0; i < tablinks.length; i++) {
        tablinks[i].className = tablinks[i].className.replace(" active", "");
    }

    evt.classList.add("active");
}

console.log(parent.JSONval.driverName);

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


function makeOrderItem(e){
  var currentItem = e.findItemsByProductResponse[0].searchResult[0].item[0];
  main = document.getElementById("orderContent");
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
          nameP = document.createElement('div');
          nameP.setAttribute("class","card-text order-title");
          nameP.setAttribute("style","width:50%;height:50%;word-break:break-all");
          nameP.innerHTML = currentItem.title[0];
          statusP = document.createElement('p');
          statusP.setAttribute("class","card-text order-status");
          if( runningCancel == false){
            statusP.innerHTML = "Status: Shipped";
          }
          else{
            statusP.innerHTML = "Status: Cancelled";
          }
          points = document.createElement('p');
          points.setAttribute("class","card-text order-points");
          points.innerHTML = Math.round(Number(currentItem.sellingStatus[0].currentPrice[0].__value__))*Number(parent.pV)+" Points";
          btn = document.createElement("button");
          btn.setAttribute("class","btn btn-primary order-button");
          btn.setAttribute("onclick","cancelOrder(this)");
          btn.innerHTML = "Cancel Order";
          if( runningCancel == true){
            btn.setAttribute("style","display:none");
          }
          itemId = document.createElement('p');
          itemId.setAttribute("style","display:none");
          itemId.innerHTML = currentItem.productId[0].__value__;

      contentDiv.appendChild(nameP);
      contentDiv.appendChild(statusP);
      contentDiv.appendChild(points);
      contentDiv.appendChild(btn);
      contentDiv.appendChild(itemId);
      imgDiv.appendChild(img);
      row.appendChild(imgDiv);
      row.appendChild(contentDiv);
      card.appendChild(row);
      main.appendChild(card);
}

// Execute the function to build the URL filter
function getOrderItem(e){
  buildURLArray(filterarray);
  var url = "http://svcs.ebay.com/services/search/FindingService/v1";
    url += "?OPERATION-NAME=findItemsByProduct";
    url += "&SERVICE-VERSION=1.0.0";
    url += "&SECURITY-APPNAME=Clemente-4910Grou-PRD-07f4c67ed-feea9193";
    url += "&GLOBAL-ID=EBAY-US";
    url += "&RESPONSE-DATA-FORMAT=JSON";
    url += "&callback=makeOrderItem";
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


function makeOrders() {
  document.getElementById("orderContent").innerHTML = "";
  runningCancel = false;
  for(i = 0; i < itemIds.length; i++){
    getOrderItem(itemIds[i]);
  }
}

function makeCancel() {
  document.getElementById("orderContent").innerHTML = "";
  runningCancel = true;
  for(i = 0; i < cancelIds.length; i++){
    getOrderItem(cancelIds[i]);
  }
}

function cancelOrder(e){
  parent.cancelIds.push(e.parentNode.children[4].innerHTML);
  var index = parent.orderIds.indexOf(e.parentNode.children[4].innerHTML);
  if (index > -1){
    parent.orderIds.splice(index,1);
    location.reload();
  }
}
