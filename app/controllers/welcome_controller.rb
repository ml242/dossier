class WelcomeController < ApplicationController
  def index
    if current_user
      @events = current_user.get_events_from_fb
      @events_invited = current_user.get_events_not_responded
      @events_maybe = current_user.get_events_maybe
    end
  end
end
