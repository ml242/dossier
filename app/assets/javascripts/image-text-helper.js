$(function() {

  $('body').on('click', '.image-text', function(e) {
    $(this).toggleClass('invisible');
    console.log(this)
  });

});