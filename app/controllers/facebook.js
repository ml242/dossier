// https://developers.facebook.com/docs/graph-api/reference/v2.1/event

import Ember from 'ember';

export default Ember.Controller.extend({
  fbKeyDev: '762893740391021',
  fbKeyProd: '683432475029309',
  redirectUri: "http://dossier-app.herokuapp.com/auth/facebook/callback",

  actions: {
    initScripts: function() {
      this.onInitScripts();
    },
    getImages: function(selectedEvent) {
      this.onGetImages(selectedEvent);
    }
  },

  onLogin: function(response) {
    if (response.authResponse) {
      console.log(response.authResponse);
      this.set('accessToken',response.authResponse.accessToken);
      this.set('userId',response.authResponse.userId);
      this.getEventsAttending();
      this.getEventsNotReplied();
      this.set('isLoggedIn', true);
    }
  },

  onInitScripts: function() {
    var self = this;
    Ember.$('body').prepend('<div id="fb-root"></div>');
    (function(d, s, id) {
      var fjs, js; js = void 0; fjs = d.getElementsByTagName(s)[0];
      if (d.getElementById(id)) return;
      js = d.createElement(s); js.id = id;
      js.src = "//connect.facebook.net/en_US/all.js#xfbml=1&appId="+self.get('fbKeyDev');
      return fjs.parentNode.insertBefore(js, fjs);
    })(document, "script", "facebook-jssdk");
    return Ember.$.ajax({
      url: window.location.protocol + "//connect.facebook.net/en_US/all.js",
      dataType: 'script',
      cache: true
    }, window.fbAsyncInit = this.onAfterInit.bind(this));
  },

  onAfterInit: function() {
    var self = this;
    Ember.$('body').on('click', '.fb-sign-in', function(e) {
      e.preventDefault();
      if (navigator.userAgent.match('CriOS')) {
        var url = "https://www.facebook.com/dialog/oauth?client_id=" +
          self.get('fbKey') + "&redirect_uri=" + self.get('redirectUri');
        return window.location = url;
      } else {
        return FB.login((function(response) {
          self.onLogin(response);
        }), {
          scope: "email, user_birthday, user_likes, user_location, " +
            "user_events, rsvp_event"
        });
      }
    });
    return Ember.$('body').on('click', '.fb-sign-out', function() {
      FB.getLoginStatus(function(response) {
        if (response.authResponse) {
          FB.logout();
          Ember.$(".fb-select-container").fadeOut(500, function() {
            Ember.$(".fb-select-container").html("");
          });
        }
      });
      return true;
    });
  },

  onGetImages: function(eventId) {
    var self = this;
    var store = this.get('store');
    this.getEventAttendees(eventId).then(function(attendees) {
      attendees.data.forEach(function(attendee) {
        self.getPicture(attendee.id).then(function(picture) {
          store.find('user', 1).then(function(user) {
            store.createRecord('image', {
              url: picture.data.url,
              name: attendee.name,
              user: user
            }); 
          });
        });
      });
    });
  },

  getPicture: function(id) {
    var url = 'http://graph.facebook.com/' + id +
      '/picture?type=large&redirect=false&width=400&height=400';
    return new Ember.RSVP.Promise(function(resolve, reject) {
      try {
        Ember.$.get(url, function(response) {
          resolve(response);
        });
      } catch(err) {
        reject(err);
      }
    });
  },

  getEventAttendees: function(eventId) {
    return new Ember.RSVP.Promise(function(resolve, reject) {
      try {
        FB.api('/'+eventId+'/attending', function(response) {
          resolve(response);
        });
      } catch(err) {
        reject(err);
      }
    });
  },

  setRSVP: function(eventId, RSVPstatus) {
    return new Ember.RSVP.Promise(function(resolve, reject) {
      try {
        FB.api('/'+eventId+'/'+RSVPstatus, 'post', function(response) {
          if (response) {
            Ember.$('.container').fadeOut(1000);
            window.location = "/";
          }
        });
      } catch(err) {
        reject(err);
      }
    });
  },

  getEventInfo: function(eventId) {
    FB.api('/'+eventId, function(response) {
      console.log(response);
      //response.venue.street+" "+response.venue.state+
      //      " "+response.venue.zip));
    });
  },

  getEventsAttending: function() {
    var self = this;
    FB.api('/me/events', function(response) {
      console.log(response);
      // add placeholder text
      response.data.unshift({id:'', name:'You\'re going to:'});
      self.get('container').lookup('controller:index')
        .set('eventsAttending',response.data);
    });
  },

  getEventsNotReplied: function() {
    var self = this;
    FB.api('/me/events/not_replied', function(response) {
      // add placeholder text
      response.data.unshift({id:'',name:'You\'re invited to:'});
      self.get('container').lookup('controller:index')
        .set('eventsNotReplied',response.data);
    });
  },

  getEventsDeclined: function() {
    var self = this;
    FB.api('/me/events/declined', function(response) {
      self.get('container').lookup('controller:index')
        .set('eventsDeclined',response.data);
    });
  }

});
