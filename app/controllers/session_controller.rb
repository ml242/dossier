class SessionController < ApplicationController

  def new
  end

  def create
    auth_hash = request.env["omniauth.auth"]
    if User.where(:uid => auth_hash["uid"]).empty?
      @user = User.new
      @user.uid = auth_hash["uid"]
      @user.name = auth_hash["info"]["nickname"]
      @user.image = auth_hash["info"]["image"]
      @user.save
      # @current_user = @user
      session[:user_id] = @user.id
      # session[:name] = @user.name
      # session[:image] = @user.image
      redirect_to("/cases")
    else @user = User.where(:uid => auth_hash["uid"]).first
      session[:user_id] = @user.id
      @user.uid = auth_hash["uid"]
      @user.name = auth_hash["info"]["nickname"]
      @user.image = auth_hash["info"]["image"]
      @user.save
      # @current_user = @user
      session[:user_id] = @user.id
      # session[:name] = @user.name
      # session[:image] = @user.image
      # render :text => "Welcome back #{@user.name}! You have already signed up."
      redirect_to("/cases")
    end
  end

  def destroy
    session[:user_id] = nil
    #TODO test these session routes, see below
    # I need to test these because they can probably be taken out
    session["session_id"] = nil
    session["_csrf_token"] = nil
    session["oauth"]["twitter"]["callback_confirmed"] = false
    redirect_to root_url, :notice => "Signed out!"
    # redirect_to root_url

  end

end