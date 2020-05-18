class RecipesController < ApplicationController
  before_action :set_recipe, only: [:show, :publish, :unpublish]
  before_action :authorize_access, only: [:show]
  before_action :authorize_action, only: [:publish, :unpublish]

  # GET /recipes
  def index
    if params[:search]&& !params[:search].empty?
      @recipes = Recipe.published.search_by_title(params[:search]).order(:title)
    else
      @recipes = Recipe.published.order(:title)
    end
    @most_popular_categories = Category.all.order(recipes_count: :desc).limit(4)

    set_meta_tags title: 'Recettes',
                  description: 'Toutes les recettes',
                  keywords: @recipes.limit(20).map(&:title).join(', ')
  end

  # GET /recipes/1
  def show
    @categories = @recipe.categories.all.order(:title)
    set_meta_tags title: 'Recettes' + @recipe.title,
                  description: helpers.no_markdown(@recipe.story)[0..160],
                  keywords: @categories.limit(20).map(&:title).join(', ')
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
      @recipe = Recipe.friendly.find(params[:id])
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
