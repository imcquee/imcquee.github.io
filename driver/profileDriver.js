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

function setPv() {
  console.log("here");
  document.getElementById("pvalue").innerHTML = parent.pV;
}

function makeSponsorOptions(){
  optionList = document.getElementById("myDropdown");
  optionList.innerHTML = "";
  for(i = 0; i < 4; i++){
    pTag = document.createElement('p');
    pTag.setAttribute("class",'sponsorOption');
    pTag.innerHTML = "Option "+i;
    optionList.appendChild(pTag);
  }
}

function changeSponsor(){

}
