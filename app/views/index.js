import Ember from 'ember';

export default Ember.View.extend({
  didInsertElement: function() {
    this.get('container').lookup('controller:facebook')
      .send('initScripts');
  }
});
