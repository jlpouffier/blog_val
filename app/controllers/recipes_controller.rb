class RecipesController < ApplicationController
  before_action :set_recipe, only: [:show, :publish, :unpublish]
  before_action :authorize_access, only: [:show]
  before_action :authorize_action, only: [:publish, :unpublish]

  # GET /recipes
  # GET /recipes.json
  def index
    if params[:search]
      @recipes = Recipe.search(params[:search]).order("created_at DESC")
    else
      @recipes = Recipe.all.order("created_at DESC")
    end
    @categories = Category.all.order("created_at DESC")
  end

  # GET /recipes/1
  # GET /recipes/1.json
  def show
  end

  def publish
    @recipe.public = true
    @recipe.created_at = Time.now  
    @recipe.save
    redirect_to @recipe
  end

  def unpublish
    @recipe.public = false
    @recipe.save
    redirect_to @recipe
  end

  private
    # Use callbacks to share common setup or constraints between actions.
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
