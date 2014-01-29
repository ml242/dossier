var numCorrect = 0,
    numWrong = 0;

function gotCorrect() {
  numCorrect ++;
}

function gotWrong() {
  numWrong ++;
}

function isActualName(el) {
  var $el = $(el),
      name = $el.text(),
      isReal = $el.data('is-real'),
      $parent = $el.parent(),
      numTries = $parent.data('tries');

  $parent.data('tries', 1);

  if (isReal) {
    gotCorrect();
    $el.addClass('correct-answer')
    $parent.html('');
    $parent.text(name);
    $parent.addClass('winner');

  } else {
    gotWrong();
    $el.addClass('wrong-answer');

    if (numTries == 1) {
      $parent.addClass('loser');
    }
  }
}

$(function() {

  $('body').on('click', '.image-subtext h3', function(e) {
    e.preventDefault();

    isActualName(this);
  });

});
