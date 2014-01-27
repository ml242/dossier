function onLinkedInAuth() {
  var mID = window.IN.User.getMemberId();
  console.log(mID);
  IN.Event.on(IN, "auth", onLinkedInAuth);
  // $.post('/linkedinauth');
 }

function onLinkedInLoad() {
  console.log("is this thing on?");
  IN.API.Profile("me").result(displayProfiles);
  console.log(displayProfiles);
}

function displayProfiles(profiles) {
  member = profiles.values[0];
  document.getElementById("profiles").innerHTML =
  "<p id=\"" + member.id + "\">Hello " +  member.firstName + " " + member.lastName + "</p>";
}