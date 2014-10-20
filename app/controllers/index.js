import Ember from 'ember';

export default Ember.Controller.extend({
  needs: ['application', 'facebook'],
  loggedInFacebook: Ember.computed.alias('controllers.facebook.isLoggedIn'),

  isEventSelected: function() {
    return this.get('selectedEventAttending') ||
      this.get('selectedEventNotReplied');
  }.property('selectedEventAttending','selectedEventNotReplied'),

  onSelectedEventAttending: function() {
    var selectedEvent = this.get('selectedEventAttending');
    if (selectedEvent)
      this.get('controllers.facebook').send('getImages',selectedEvent);
  }.observes('selectedEventAttending'),

  onSelectedEventNotReplied: function() {
    var selectedEvent = this.get('selectedEventNotReplied');
    if (selectedEvent)
      this.get('controllers.facebook').send('getImages',selectedEvent);
  }.observes('selectedEventNotReplied'),

  onRsvpChange: function() {
    var selectedEvent = this.get('selectedEvent');
    var rsvp = this.get('selectedEventRsvp');
    if (rsvp)
      this.get('controllers.facebook').send('setRsvp', selectedEvent, rsvp);
  }.observes('rsvp')
});
