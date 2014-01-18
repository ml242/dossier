Rails.application.config.middleware.use OmniAuth::Builder do
  # APP_ID = ENV['DOSSIER_FACEBOOK_KEY']
  # APP_SECRET = ENV['DOSSIER_FACEBOOK_SECRET']
  # provider :facebook, APP_ID, APP_SECRET, {:provider_ignores_state => true}
  provider :facebook, FACEBOOK_ID='762893740391021', FACEBOOK_SECRET='cf0277b6889868c93fbc55fba000e38b', {:provider_ignores_state => true}
end

# OmniAuth error handling http://stackoverflow.com/a/11256549/2474735
# OmniAuth.config.on_failure = UsersController.action(:oauth_failure)
