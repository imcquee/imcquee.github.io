function setPv() {
  // document.getElementById("pvalue").innerHTML = parent.pV;
  document.getElementById('user').value = parent.JSONval.profile[0][0].sponsorName;
  document.getElementById('password').value = parent.JSONval.profile[0][0].sponsorPassword;
  document.getElementById('email').value = parent.JSONval.profile[0][0].sponsorEmail;
}
