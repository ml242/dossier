class WelcomeController < ApplicationController
  def index
    if current_user
      @events = current_user.get_events_from_fb
    end
  end
end
