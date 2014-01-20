class SessionsController < ApplicationController

  def create
    if session[:user_id]
      # if user already has a user_id in session
      # from an alternate login method
      # pass the user_id in
      user = User.from_omniauth(env['omniauth.auth'], session[:user_id])
      session[:fb_login] = true
    else
      user = User.from_omniauth(env['omniauth.auth'], nil)
      session[:user_id] = user.id
      session[:fb_login] = true
    end
    redirect_to root_url
  end

  def destroy
    reset_session
    # session[:user_id] = nil
    # session[:fb_login] = nil
    # session[:session_id] = nil
    # session[:_csrf_token] = nil
    # session[:session_id] = nil
    redirect_to root_url, :notice => "Signed out!"
  end

end
