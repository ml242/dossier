function showInSelect() {
  var $inLogo = $('<div>').addClass('in-logo').addClass('select-logo');
      $inSelect = $('<select>').addClass('in-select');
      $inContainer = $('<div>').addClass('in-select-container');

  $('<option>')
    .text('View your Connections')
    .attr('value', 0)
    .appendTo($inSelect);

  $('<option>')
    .text('All LinkedIn Connections')
    .attr('value', 1)
    .appendTo($inSelect);

  $inLogo.appendTo($inContainer);
  $inSelect.appendTo($inContainer);

  $('.sub-header')
    .append($inContainer);
}

function getInConnections() {
  IN.API.Connections("me")
    .fields("firstName", "lastName", "picture-urls::(original)", "publicProfileUrl", "headline", "id")
    .result(function(res) {

      for (var i=0, numPeeps = res.values.length; i<numPeeps; i++) {
        var peep = res.values[i];
        if (peep.pictureUrls && peep.pictureUrls.values) {

          $aTag = $('<a>').addClass('image-wrapper');

          $('<div>')
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

  $('body').on('click', 'span', function(e) {
    // stop propagation because linkedin login button is awful
    e.stopPropagation();
  });

});