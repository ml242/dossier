class WelcomeController < ApplicationController
  def index
    if current_user
      begin
        @events = current_user.get_events_from_fb
        @events_invited = current_user.get_events_not_responded
        @events_maybe = current_user.get_events_maybe
      rescue
        reset_session
      end
    end
  end
end
