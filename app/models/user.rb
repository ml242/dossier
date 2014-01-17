class User < ActiveRecord::Base
  attr_accessible :fb_id, :meetup_id, :linkedin_id, :email, :first_name, :last_name, :picture_url, :facebook_access_token, :facebook_expires_at

  def from_omniauth(auth, user_id)
    if user_id
      user = User.find user_id
      user.facebook_id = auth.uid
      user.email = auth.extra.raw_info.email if !user.email
      user.first_name = auth.info.first_name
      user.last_name = auth.info.last_name
      user.facebook_access_token = auth.credentials.token
      user.facebook_expires_at = Time.at(auth.credentials.expires_at)
      user.save!
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
  end

end
