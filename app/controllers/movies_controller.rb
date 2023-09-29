class MoviesController < ApplicationController
  before_action :authenticate_user!
  def index
    @movies = Movie.all
  end

  def new
    @movie = Movie.new
  end

  def create
    @movie = Movie.new(movie_params)
    if @movie.save
      redirect_to movies_path
    else
      render :new, status: 422
    end
  end
  
  private
    def movie_params
      params
        .require(:movie)
        .permit(
          :movie_name,
          :price,
          :movie_image
        )
    end
end
