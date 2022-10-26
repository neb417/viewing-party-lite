class UsersController < ApplicationController
  def new; end

  def create
    user = User.new(user_params)

    if user.save
      session[:user_id] = user.id
      require_user
      redirect_to session.delete(:return_to) || dashboard_path
      flash[:success] = "Welcome #{user.name}"
    else
      redirect_to register_path
      flash[:alert] = user.errors.full_messages.to_sentence
    end
  end

  def login_form; end

  def login_user
    user = User.find_by_email(params[:email])
    if user&.authenticate(params[:password])
      session[:user_id] = user.id
      require_user
      # give_token
      flash[:success] = "Welcome #{user.name}"
      redirect_to session.delete(:return_to) || dashboard_path
    else
      flash[:alert] = 'User name and/or password is incorrect'
      redirect_to login_path
    end
  end

  private

  def user_params
    params.permit(:name, :email, :password, :password_confirmation)
  end
end
