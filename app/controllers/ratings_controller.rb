# app/controllers/ratings_controller.rb

class RatingsController < ApplicationController

  def new
    @rating = Rating.new
  end

  def create
    @movie = Movie.friendly.find(params[:movie_id])
    @rating = @movie.ratings.create(
      rating_params.merge("user": current_user)
    )
    redirect_to request.referrer
  end

  def edit
    @rating = Rating.find(params[:id])
  end

  def update
    @rating = Rating.find(params[:id])
    @rating.update(
      rating_params.merge("user": current_user)
    )

    respond_to do |format|
      # format.js
      format.js { render layout: false }
      # format.js { render layout: false, content_type: 'text/javascript' }
      format.html {redirect_to request.referrer}
    end

  end

  def destroy
    @movie = Movie.friendly.find(params[:movie_id])
    @rating = @movie.ratings.find(params[:id])
    @rating.destroy
    redirect_to request.referrer
  end

  private 
    def rating_params
      params.require(:rating).permit(:score)
    end

end
