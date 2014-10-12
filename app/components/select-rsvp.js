import Ember from 'ember';

export default Ember.Component.extend({
  tagName: 'span',
  content: [
    { value: '', label: 'RSVP' },
    { value: 'attending', label: 'Going' },
    { value: 'declined', label: 'Not going' },
    { value: 'maybe', label: 'Maybe' }
  ]
});
