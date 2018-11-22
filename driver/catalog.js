var itemIds = parent.itemIds;

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
    // console.log(currentItem);
    main = document.getElementById("mainCatalog");
    cardDiv = document.createElement("div");
    card = document.createElement("div");
      img = document.createElement("img");
      cardBody = document.createElement("div");
        h5 = document.createElement("h5");
        p = document.createElement("p");
        butn = document.createElement("button");

    cardDiv.setAttribute("onclick","displayItemOverlay();displayItem(this)");
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
        butn.setAttribute("style","margin:auto");
        butn.setAttribute("onclick","event.stopPropagation();addToCart(this)");
        itemId = document.createElement('p');
        itemId.setAttribute("style","display:none");
        itemId.innerHTML = currentItem.productId[0].__value__;
        h5.innerHTML = currentItem.title[0];
        p.innerHTML = Math.round(Number(currentItem.sellingStatus[0].currentPrice[0].__value__));
        butn.innerHTML = "Add to Cart";

        h5Div.appendChild(h5)
        cardBody.appendChild(h5Div);
        cardBody.appendChild(p);
        cardBody.appendChild(butn);
        cardBody.appendChild(itemId);
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

function makeCatalog(){
  for(i = 0; i < itemIds.length; i++){
    getCatalogItem(itemIds[i]);
  }
}

function addToCart(e){
  parent.cartIds.push(e.parentNode.children[3].innerHTML);
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
  itemContent.children[0].children[0].setAttribute("style","width:25vh;height:25vh;margin-left:0");
  itemContent.children[0].setAttribute("style","margin-top:5%;margin-left:3.5%;margin-right:2.5%");
}

function closeItemOverlay(){
  document.getElementById("itemOverlay").style.display = "none";
  document.getElementById("overlayContent").style.display = "none";
  document.documentElement.style.overflow = 'scroll';
  document.body.scroll = "yes";
}
