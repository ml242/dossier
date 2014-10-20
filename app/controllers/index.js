import Ember from 'ember';

export default Ember.Controller.extend({
  needs: ['application', 'facebook'],
  loggedInFacebook: Ember.computed.alias('controllers.facebook.isLoggedIn'),
  currentEventId: null,

  onSelectedEventAttending: function() {
    var selectedEventId = this.get('selectedEventAttending');
    if (selectedEventId) {
      this.set('currentEventId', selectedEventId);
      var fbCtrl = this.get('controllers.facebook');
      fbCtrl.send('getImages', selectedEventId);
      fbCtrl.send('getInfo', selectedEventId);
    }
  }.observes('selectedEventAttending'),

  onSelectedEventNotReplied: function() {
    var selectedEventId = this.get('selectedEventNotReplied');
    if (selectedEventId) {
      this.set('currentEventId', selectedEventId);
      var fbCtrl = this.get('controllers.facebook');
      fbCtrl.send('getImages', selectedEventId);
      fbCtrl.send('getInfo', selectedEventId);
    }
  }.observes('selectedEventNotReplied'),

  onRsvpChange: function() {
    var currentEventId = this.get('currentEventId');
    var rsvp = this.get('rsvp');
    if (currentEventId && rsvp)
      this.get('controllers.facebook').send('setRsvp', currentEventId, rsvp);
  }.observes('rsvp')
});
