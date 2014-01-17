class ApplicationController < ActionController::Base
  protect_from_forgery

private

  def current_user
    if session[:user_id]
      sesh_arr = User.where(id: session[:user_id])
      if sesh_arr.present?
        @current_user = sesh_arr.first
      else
        session = nil
        redirect_to('/signout')
      end
    end
  end

  helper_method :current_user
end
