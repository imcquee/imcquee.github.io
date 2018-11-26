/* When the user clicks on the button,
toggle between hiding and showing the dropdown content */
function myFunction() {
    document.getElementById("myDropdown").classList.toggle("show");
    document.getElementById("sponsorSelect").blur();
}

// Close the dropdown menu if the user clicks outside of it
window.onclick = function(event) {
  if (!event.target.matches('.dropbtn')) {

    if(event.target.matches('.sponsorOption')){
      document.getElementById("sponsorSelect").value = event.target.innerHTML;
    }
    var dropdowns = document.getElementsByClassName("dropdown-content");
    var i;
    for (i = 0; i < dropdowns.length; i++) {
      var openDropdown = dropdowns[i];
      if (openDropdown.classList.contains('show')) {
        openDropdown.classList.remove('show');
      }
    }
  }
}
//console.log(parent.JSONval.driverPassword);
console.log(parent.JSONval);
function setPv() {
  //document.getElementById("pvalue").innerHTML = parent.pV;
  document.getElementById('user').value = parent.JSONval.profile[0][0].driverName;
  document.getElementById('password').value = parent.JSONval.profile[0][0].driverPassword;
  document.getElementById('email').value = parent.JSONval.profile[0][0].driverEmail;
}

function makeSponsorOptions(){
  optionList = document.getElementById("myDropdown");
  optionList.innerHTML = "";
  for(i = 1; i < parent.JSONval.sponsors.length; i++){
     var pTag = document.createElement('p');
    pTag.setAttribute("class",'sponsorOption');
    pTag.innerHTML = parent.JSONval.sponsors[i].sponsors.sponsorName;
    optionList.appendChild(pTag);
  }
}

function changeSponsor(){
  if(document.getElementById('sponsorSelect').value == "TestSp2"){
    parent.itemIds = parent.sp2Ids;
    parent.pV = parent.sp2PV;
    //document.getElementById("pvalue").innerHTML = parent.pV;
    //if( parent.JSONval.drivers.leng)
    window.parent.document.getElementById('driverPoints').innerHTML = parent.JSONval.points[1].points.driverPoints;
    window.parent.document.getElementById('current-sponsor').innerHTML = "TestSp2";
  }
  else{
    parent.itemIds = parent.sp1Ids;
    parent.pV = parent.sp1PV;
    //document.getElementById("pvalue").innerHTML = parent.pV;
    window.parent.document.getElementById('driverPoints').innerHTML = parent.JSONval.points[0].points.driverPoints;
    window.parent.document.getElementById('current-sponsor').innerHTML = "TestSp1";
  }
}
