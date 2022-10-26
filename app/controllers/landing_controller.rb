class LandingController < ApplicationController
  def index
    @users = User.all
  end

  def delete
    session.destroy
    flash[:success] = 'You have successfully logged out'
    redirect_to root_path
  end
end