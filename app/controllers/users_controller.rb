class UsersController < ApplicationController
  def show
    @user = User.find_by id: params[:id]
    @events = @user.events.recent
  end
end
