class Admin::CategoriesController < ApplicationController
  before_action :set_category, except: [:index, :create]

  def index
    @categories = Category.all
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    @category.save!
    redirect_back(fallback_location: root_path)
  end

  def edit
    @categories = Category.all
    render :index
  end

  def update
    @category.update(category_params)
    redirect_to admin_categories_path
  end

  def destroy
    @category.destroy
    redirect_back(fallback_location: root_path)
  end

  private 

  def set_category
    @category = Category.find(params[:id])
  end

  def category_params
    params.require(:category).permit(:name)
  end
end
