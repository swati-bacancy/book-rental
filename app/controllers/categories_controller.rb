class CategoriesController < ApplicationController
  before_action :authenticate_person!

  load_and_authorize_resource

  layout "devicelayout"
  def new
    @category=Category.new
  end

  def create
    @category=Category.new(category_params)
    @category.save
    redirect_to categories_path 

  end
  def show
     @category=Category.find(params[:id])
  end
  def index
    @categories=Category.all
  end
  def destroy
    @category=Category.find(params[:id])
    @category.destroy
    redirect_to categories_path
  end

  def edit
    @category=Category.find(params[:id])
  end
  def update
    @category=Category.find(params[:id])
    if @category.update_attributes(category_params)
      redirect_to categories_path 
    else
      render 'edit'
    end
  end
  private
  def category_params
    params.require(:category).permit(:category_name)
  end
end
