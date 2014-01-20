Rails.application.config.middleware.use OmniAuth::Builder do
  APP_ID = ENV['DOSSIER_FACEBOOK_KEY']
  APP_SECRET = ENV['DOSSIER_FACEBOOK_SECRET']
  provider :facebook, APP_ID, APP_SECRET, {:provider_ignores_state => true}
  Key = ENV['Meetup_ID']
  Secret = Env['Meetup_Secret']
  provider :meetup, Key, Secret
end

# OmniAuth error handling http://stackoverflow.com/a/11256549/2474735
# OmniAuth.config.on_failure = UsersController.action(:oauth_failure)
