class ApplicationController < ActionController::Base
  helper_method :current_user

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def require_user
    unless current_user
      flash[:error] = 'You must be a registered user to access this page'
      session[:return_to] = request.path
      redirect_to login_path
    end
  end
end
