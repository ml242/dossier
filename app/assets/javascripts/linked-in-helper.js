function getInConnections() {

  IN.API.Connections("me")
    .fields("firstName", "lastName", "picture-urls::(original)", "publicProfileUrl", "headline", "id")
    .result(function(res) {

      console.log(res);

      for (var i=0, numPeeps = res.values.length; i<numPeeps; i++) {

        var peep = res.values[i];
        if (peep.pictureUrls && peep.pictureUrls.values) {

          $aTag = $('<a>').addClass('image-wrapper');

          $('<span>')
            .addClass('image-text')
            .addClass('invisible')
            .html("<h1>" + peep.firstName + " " + peep.lastName + "</h1><br /><h2>" + peep.headline + "</h2>")
            .appendTo($aTag);

          $('<img>')
            .attr('src', peep.pictureUrls.values[0])
            .addClass('attendee')
            .appendTo($aTag);

          $('.event-container').append($aTag);
        }
      }
    });
}

$(function() {

  $('body').on('click', '.linked-sign-in', function(e) {
    e.preventDefault();
    $(this).find("span").last().click();
  });

  $('body').on('click', 'span', function(e) {
    e.stopPropagation();
  });

  $('body').on('click', '.linked-sign-out', function(e) {
    e.preventDefault();
    IN.User.logout();
    $('.event-container').fadeOut(1000, function(e) {
      $('.event-container').html('');
    });
  });

   window.IN.Event.on(IN, "auth", function(event) {
     console.log('its working');
     console.log(event);
    $('.linked-sign-in').addClass('hidden');
    $('.linked-sign-out').removeClass('hidden');
    $('.event-container').html('');
   });

  window.IN.Event.on(IN, "logout", function(event) {
    $('.linked-sign-in').removeClass('hidden');
    $('.linked-sign-out').addClass('hidden');
  });


});
