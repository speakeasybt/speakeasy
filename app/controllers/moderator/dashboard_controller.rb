class Moderator::DashboardController < ApplicationController
  def index
    @events = Event.recent
  end
end
