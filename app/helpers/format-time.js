import Ember from 'ember';

function formatTime(value) {
  return moment(value).format('MMM Do YYYY, h:mm a');
}

export {
  formatTime
};

export default Ember.Handlebars.makeBoundHelper(formatTime);
