class DashboardController < ApplicationController

  def show
    if session[:user_id].nil?
      require_user
    else
      @user = User.find(session[:user_id])
    end
  end
end
