class RecipesController < ApplicationController
  before_action :set_recipe, only: [:show, :publish, :unpublish]
  before_action :authorize_access, only: [:show]
  before_action :authorize_action, only: [:publish, :unpublish]

  # GET /recipes
  def index
    if params[:search]
      @recipes = Recipe.search(params[:search]).order(:title)
    else
      @recipes = Recipe.all.order(:title)
    end
    @most_popular_categories = Category.all.order(recipes_count: :desc).limit(4)
  end

  # GET /recipes/1
  def show
  end

  # POST /recipes/id/publish
  def publish
    @recipe.public = true
    @recipe.created_at = Time.now  
    @recipe.save
    redirect_to @recipe
  end

  # POST /recipes/id/unpublish
  def unpublish
    @recipe.public = false
    @recipe.save
    redirect_to @recipe
  end

  private
    def set_recipe
      @recipe = Recipe.find(params[:id])
    end

    def authorize_access
      unless (@recipe.public?  or current_user.present?)
        render file: "#{Rails.root}/public/403.html", layout: false, status: 403
      end
    end

    def authorize_action
      unless current_user.present?
        render file: "#{Rails.root}/public/403.html", layout: false, status: 403
      end
    end
end
