function onLinkedInAuth() {
  var mID = window.IN.User.getMemberId();
  debugger;
  // $.post('/linkedinauth');
 }

function onLinkedInLoad() {
  window.IN.Event.on(IN, "auth", onLinkedInAuth);
}

       // onLinkedInLoad = ->
        // IN.Event.on IN, "auth", onLinkedInAuth

      // onLinkedInAuth = ->
        // IN.API.Profile("me").result displayProfiles
