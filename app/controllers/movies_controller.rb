class MoviesController < ApplicationController
  def index
    @user = User.find(session[:user_id])
    if params[:q] == 'top_rated'
      @top_movies = MovieFacade.top_rated
    else params[:q]
      @searched_movies = MovieFacade.search(params[:q])
    end
  end

  def show
    if session[:user_id].nil?
      @movie = MovieFacade.details(params[:id])
      # flash[:error] = 'You must be logged in to create a party'
      # redirect_to root_path
    else
      @movie = MovieFacade.details(params[:id])
      @user = User.find(session[:user_id])
    end
  end
end

