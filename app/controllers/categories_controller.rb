class CategoriesController < ApplicationController
  before_action :set_category, only: [:show]

  # GET /categories
  def index
    @categories = Category.all.order(:title)
  end

  # GET /categories/1
  def show
    @recipes = @category.recipes.published.order(:title)
  end

  private
    def set_category
      @category = Category.find(params[:id])
    end
end
