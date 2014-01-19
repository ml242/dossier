class WelcomeController < ApplicationController
  def index
    @events = current_user.get_events_from_fb || []
  end
end
