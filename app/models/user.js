import DS from 'ember-data';

export default DS.Model.extend({
  images: DS.hasMany('images')  
});
