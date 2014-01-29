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
      isReal = $el.data('is-real'),
      $parent = $el.parent(),
      name = $parent.data('real-name'),
      numTries = $parent.data('tries');

  $parent.data('tries', numTries + 1);

  if (isReal) {
    gotCorrect();
    $el.addClass('correct-answer')
    $parent.html('');
    $parent.text(name);
    $parent.addClass('winner');

  } else {
    gotWrong();
    $el.addClass('incorrect-answer');

    if (numTries == 2) {
      $parent.html('');
      $parent.text(name);
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
