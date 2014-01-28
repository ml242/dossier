class User < ActiveRecord::Base
  attr_accessible :facebook_id, :meetup_id, :linkedin_id, :email, :first_name, :last_name, :picture_url, :facebook_access_token, :facebook_expires_at

  def self.from_omniauth(auth, user_id)
    if user_id
      user = User.find user_id
      user.facebook_id = auth.uid
      user.email = auth.extra.raw_info.email if !user.email
      user.first_name = auth.info.first_name
      user.last_name = auth.info.last_name
      user.facebook_access_token = auth.credentials.token
      user.facebook_expires_at = Time.at(auth.credentials.expires_at)
    else
      user = User.where(facebook_id: auth.uid).first_or_initialize.tap do |user|
        user.facebook_id = auth.uid
        user.email = auth.extra.raw_info.email if !user.email
        user.first_name = auth.info.first_name
        user.last_name = auth.info.last_name
        user.facebook_access_token = auth.credentials.token
        user.facebook_expires_at = Time.at(auth.credentials.expires_at)
      end
    end
    user.save!
    user
  end

  def get_events_from_fb
    begin 
      graph = Koala::Facebook::API.new(self.facebook_access_token)
      @events = graph.get_connections("me", "events")
    rescue
      reset_session
    end
  end

  def get_events_not_responded
    begin
      graph = Koala::Facebook::API.new(self.facebook_access_token)
      @events_invited = graph.get_connections("me", "events/not_replied")
    rescue
      reset_session
    end
  end

  def get_events_maybe
    begin
      graph = Koala::Facebook::API.new(self.facebook_access_token)
      @events_maybe = graph.get_connections("me", "events/maybe")
    rescue
      reset_session
    end
  end

end
