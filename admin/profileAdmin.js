function setPv() {
  // document.getElementById("pvalue").innerHTML = parent.pV;
  document.getElementById('user').value = parent.JSONval.profile[0][0].adminName;
  document.getElementById('password').value = parent.JSONval.profile[0][0].adminPassword;
  document.getElementById('email').value = parent.JSONval.profile[0][0].adminEmail;
}
