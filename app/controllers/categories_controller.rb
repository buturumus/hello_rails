# app/controllers/categories_controller.rb

class CategoriesController < ApplicationController

  def index
    @categories = Category.all
  end

  def panel
    @categories = Category.find_mine(current_user)
  end

  def show
    @category = Category.friendly.find(params[:id])
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(
      category_params.merge(:user_id => current_user.id)
    )
    if @category.save
      redirect_to @category
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @category = Category.friendly.find(params[:id])
  end

  def update
    @category = Category.friendly.find(params[:id])
    @category = nil if @category.user_id != current_user.id 
    if @category.update(category_params)
      redirect_to @category
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @category = Category.friendly.find(params[:id])
    @category.destroy
    redirect_to panel_categories_path, status: :see_other
  end

  private
    def category_params
      params.require(:category).permit(:name)
    end

end
