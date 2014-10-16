import Ember from 'ember';

export default Ember.Component.extend({
  click: function() {
    console.log(this.$());
    var image = this.$().find('.invisible')
    image.toggleClass('invisible');   
  }
});

