import Ember from 'ember';

export default Ember.Component.extend({
  click: function() {
    console.log(this.$());
    var imageText = this.$().find('.image-text')
    imageText.toggleClass('invisible');   
  }
});

