import Ember from 'ember';

export default Ember.Controller.extend({
  needs: ['application'],
  loggedInFacebook: Ember.computed.alias(
    'controllers.application.loggedInFacebook'),
  loggedIn: function() {
    var facebook = this.get('loggedInFacebook');
    return !!facebook;
  }.property('loggedInFacebook'),

  onSelectedEventAttendingChange: function() {
    var selectedEvent = this.get('selectedEventAttending');
    this.onSelectedEvent(selectedEvent);
  }.observes('selectedEventAttending'),
  onSelectedEventNotReplied: function() {
    var selectedEvent = this.get('selectedEventNotReplied');
    this.onSelectedEvent(selectedEvent);
  }.observes('selectedEventNotReplied'),
  onSelectedEvent: function(selectedEvent) {
    this.set('selectedEvent',selectedEvent);
    this.get('container').lookup('controller:facebook')
      .send('getImages',selectedEvent);
  }
});
