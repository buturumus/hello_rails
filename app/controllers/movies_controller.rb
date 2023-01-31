# app/controllers/movies_controller.rb

class MoviesController < ApplicationController

  def index
    # @movies = Movie.order(:title)
    #                .page(params[:page])
    #                .per(current_user.per_page)

    @movies = Movie.order(:title).page params[:page]
  end

  def panel
    @movies = Movie.find_mine(current_user)
  end

  def show
    @movie = Movie.friendly.find(params[:id])
    # @movie = Movie.find(params[:id])
  end

  def new
    @movie = Movie.new
  end

  def create
    p = movie_params
    if p[:add_category_ids] == "" 
      redirect_to new_movie_path, status: :unprocessable_entity
      return
    end
    p[:category_ids] = p[:add_category_ids]
    p.delete(:add_category_ids)
    p.delete(:del_category_ids)
    @movie = Movie.new(p.merge(:user_id => current_user.id))
    if @movie.save
      redirect_to @movie
    else
      render new_movie_path, status: :unprocessable_entity
    end
  end

  def edit
    @movie = Movie.friendly.find(params[:id])
  end

  def update
    @movie = Movie.friendly.find(params[:id])
    @movie = nil if @movie.user_id != current_user.id 
    p = movie_params
    p[:category_ids] = @movie.category_ids
    if (
      p[:add_category_ids] != "" && 
      # (! p[:category_ids].include? p[:add_category_ids].to_i)  # avoid dupl.
      (! p[:category_ids].include? p[:add_category_ids])  # avoid dupl.
    )
      p[:category_ids].append(p[:add_category_ids])
    end
    if (
      p[:del_category_ids] != "" &&
      p[:category_ids].length > 1 
    )
      # p[:category_ids] -= [p[:del_category_ids].to_i] 
      p[:category_ids] -= [p[:del_category_ids]]
    end
    p.delete(:add_category_ids)
    p.delete(:del_category_ids)
    if @movie.update(p)
      redirect_to @movie
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @movie = Movie.friendly.find(params[:id])
    @movie.destroy
    redirect_to panel_movies_path, status: :see_other
  end

  private
    def movie_params
      params.require(:movie).permit(
        :title, :description, :add_category_ids, :del_category_ids)
    end

end
