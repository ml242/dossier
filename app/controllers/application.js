import Ember from 'ember';

export default Ember.Controller.extend({
  needs: ['facebook'],
  isLoggedIn: Ember.computed.alias('controllers.facebook.isLoggedIn')
});
