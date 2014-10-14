/* jshint node: true */

module.exports = function(environment) {
  var ENV = {
    modulePrefix: 'dossier',
    environment: environment,
    baseURL: '/',
    locationType: 'auto',
    EmberENV: {
      FEATURES: {
        // Here you can enable experimental features on an ember canary build
        // e.g. 'with-controller': true
      }
    },

    APP: {
      // Here you can pass flags/options to your application instance
      // when it is created
    }
  };

  if (environment === 'development') {
    // ENV.APP.LOG_RESOLVER = true;
    ENV.APP.LOG_ACTIVE_GENERATION = true;
    // ENV.APP.LOG_TRANSITIONS = true;
    // ENV.APP.LOG_TRANSITIONS_INTERNAL = true;
    ENV.APP.LOG_VIEW_LOOKUPS = true;
  }

  if (environment === 'test') {
    // Testem prefers this...
    ENV.baseURL = '/';
    ENV.locationType = 'auto';

    // keep test console output quieter
    ENV.APP.LOG_ACTIVE_GENERATION = false;
    ENV.APP.LOG_VIEW_LOOKUPS = false;

    ENV.APP.rootElement = '#ember-testing';
  }

  if (environment === 'production') {

  }

  ENV.contentSecurityPolicy = {
    'default-src': "'none'",
    'connect-src': "http://graph.facebook.com",
    'img-src': "'self' http://www.facebook.com https://www.facebook.com",
    'script-src': "'self' 'unsafe-eval' 'unsafe-inline' http://connect.facebook.net https://graph.facebook.com",
    'style-src': "'self' 'unsafe-inline' http://fonts.googleapis.com",
    'font-src': "'self' http://fonts.gstatic.com",
    'media-src': "'self'",
    'frame-src': "'self' 'unsafe-inline' http://static.ak.facebook.com http://s-static.ak.facebook.com http://www.facebook.com https://static.ak.facebook.com https://s-static.ak.facebook.com https://www.facebook.com",
    'report-uri': "http://dossier.herokuapp.com/report"
  };

  return ENV;
};
