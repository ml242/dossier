import Ember from 'ember';

export default Ember.Controller.extend({
  needs: ['facebook'],
  isLoggedIn: Ember.computed.alias('controllers.facebook.isLoggedIn'),
  alerts: [],
  actions: {
    clearAlert: function(alert) {
      this.alerts.removeObject(alert);
    }
  }
});
