function makeCatalog(){
  for(i = 0;i < 10; i++){
    main = document.getElementById("mainCatalog");
    card = document.createElement("div");
      img = document.createElement("img");
      cardBody = document.createElement("div");
        h5 = document.createElement("h5");
        p = document.createElement("p");
        butn = document.createElement("button");

    card.setAttribute("class","card catalog-card");
      img.setAttribute("class","card-img-top");
      img.setAttribute("src","product_1_pic.png");
      cardBody.setAttribute("class","card-body");
      cardBody.setAttribute("style","text-align:center");
        h5.setAttribute("class","card-title");
        h5.setAttribute("style","margin:auto;padding-bottom:1vh");
        p.setAttribute("class","card-text");
        p.setAttribute("style",style="margin:auto;padding-bottom:1vh");
        butn.setAttribute("class","btn btn-primary");
        butn.setAttribute("style","margin:auto");
        butn.setAttribute("onclick","test()");

        h5.innerHTML = "Missha All Around Safe Block Sebum Zero Sun";
        p.innerHTML = "$4.00";
        butn.innerHTML = "Add to Cart";

        cardBody.appendChild(h5);
        cardBody.appendChild(p);
        cardBody.appendChild(butn);
        card.appendChild(img);
        card.appendChild(cardBody);
        main.appendChild(card);
  }
}

function test(){
  
}
