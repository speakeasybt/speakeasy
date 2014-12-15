class Moderator::DashboardController < ApplicationController
  def index
    @events = Event.recent
    @page_title = "Moderator Dashboard"
  end
end
