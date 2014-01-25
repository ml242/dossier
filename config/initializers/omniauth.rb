Rails.application.config.middleware.use OmniAuth::Builder do
  APP_ID = ENV['DOSSIER_FACEBOOK_KEY']
  APP_SECRET = ENV['DOSSIER_FACEBOOK_SECRET']
  provider :facebook, APP_ID, APP_SECRET, {:provider_ignores_state => true}
  Key = ENV['dossier_consumer_key']
  Secret = ENV['dossier_consumer_secret']
  provider :linkedin, "Key", "Secret", :scope => 'r_fullprofile r_emailaddress r_network', :fields => ["id", "email-address", "first-name", "last-name", "headline", "industry", "picture-url", "public-profile-url", "location", "connections"]
end

# OmniAuth error handling http://stackoverflow.com/a/11256549/2474735
# OmniAuth.config.on_failure = UsersController.action(:oauth_failure)
