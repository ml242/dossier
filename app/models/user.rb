class User < ActiveRecord::Base
  attr_accessible :facebook_id, :meetup_id, :linkedin_id, :email, :first_name, :last_name, :picture_url, :facebook_access_token, :facebook_expires_at

  def self.from_omniauth(auth, user_id)

    # immediately get 60 day auth token
    # https://github.com/mkdynamic/omniauth-facebook/issues/23#issuecomment-15565902
    oauth = Koala::Facebook::OAuth.new(ENV["DOSSIER_FACEBOOK_KEY"], ENV["DOSSIER_FACEBOOK_SECRET"])
    new_access_info = oauth.exchange_access_token_info auth.credentials.token

    new_access_token = new_access_info["access_token"]
    new_access_expires_at = DateTime.now + new_access_info["expires"].to_i.seconds

    # if the user already exists, update
    # if user does not exist, create
    if user_id
      user = User.find user_id
      user.facebook_id = auth.uid
      user.email = auth.extra.raw_info.email if !user.email
      user.first_name = auth.info.first_name
      user.last_name = auth.info.last_name
      user.facebook_access_token = new_access_token
      user.facebook_expires_at = new_access_expires_at
    else
      user = User.where(facebook_id: auth.uid).first_or_initialize.tap do |user|
        user.facebook_id = auth.uid
        user.email = auth.extra.raw_info.email if !user.email
        user.first_name = auth.info.first_name
        user.last_name = auth.info.last_name
        user.facebook_access_token = new_access_token
        user.facebook_expires_at = new_access_expires_at
      end
    end
    user.save!
    user
  end

  def get_events_from_fb
    graph = Koala::Facebook::API.new(self.facebook_access_token)
    @events = graph.get_connections("me", "events")
  end

  def get_events_not_responded
    graph = Koala::Facebook::API.new(self.facebook_access_token)
    @events_invited = graph.get_connections("me", "events/not_replied")
  end

  def get_events_maybe
    graph = Koala::Facebook::API.new(self.facebook_access_token)
    @events_maybe = graph.get_connections("me", "events/maybe")
  end

end
