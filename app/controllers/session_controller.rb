class SessionController < ApplicationController

  def create
    if session[:user_id]
      # if user already has a user_id in session
      # from an alternate login method
      # pass the user_id in
      user = User.from_omniauth(env['omniauth.auth'], session[:user_id])

    else
      user = User.from_omniauth(env['omniauth.auth'], nil)
      session[:user_id] = user.id
    end

    redirect_to root_url
  end
  
  def destroy
    session[:user_id] = nil
    redirect_to root_url, :notice => "Signed out!"
  end

end
