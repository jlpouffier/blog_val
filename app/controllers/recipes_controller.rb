class RecipesController < ApplicationController
  before_action :set_recipe, only: [:show, :publish, :unpublish]
  before_action :authorize_access, only: [:show]
  before_action :authorize_action, only: [:publish, :unpublish]

  # GET /recipes
  def index
    # If Search paramater, then @recipes will be set to the list of matching public recipes, order by title.
    # Else @recipes will be set to the list of all public recipes, order by title.
    if params[:search]&& !params[:search].empty?
      @recipes = Recipe.published.search_by_title(params[:search]).order(:title).page params[:page]
    else
      @recipes = Recipe.published.order(:title).page params[:page]
      # Get the 4 most popular categories (by recipes count)
      @most_popular_categories = Category.all.order(recipes_count: :desc).limit(4)
    end



    # Set the meta tags of the page. Descirption and keywords include to first 20 recipes
    # TODO: Order the keywords and description by popularity    
    set_meta_tags title: 'Recettes',
                  description: 'Toutes les recettes: ' + @recipes.map(&:title).join(', ') + ' ...',
                  keywords: @recipes.map(&:title).join(', ')
  end

  # GET /recipes/1
  def show
    # Get the related categories for that recipe, order by title
    @categories = @recipe.categories.all.order(:title)

    @recipe.punch(request)

    # Set the meta tags of the page. 
    # Descirption is the stripped down version of the recipe story (The first 160 char)
    # keywords are the related categories.
    # TODO: Order the keywords by popularity   
    set_meta_tags title: 'Recette: ' + @recipe.title,
                  description: helpers.no_markdown(@recipe.story)[0..160],
                  keywords: @categories.map(&:title).join(', ')
  end

  # POST /recipes/id/publish
  # Publish the recipe, set the created time to now. redirect tot he show page of the recipe
  def publish
    @recipe.public = true
    @recipe.created_at = Time.now  
    @recipe.save
    redirect_to @recipe
  end

  # POST /recipes/id/unpublish
  # Unpublish the recipe, redirect tot he show page of the recipe
  def unpublish
    @recipe.public = false
    @recipe.save
    redirect_to @recipe
  end

  private
    def set_recipe
      @recipe = Recipe.friendly.find(params[:id])
    end

    # before show
    # OK if the recipe if it's public or if we are logged (As blog admin)
    # else redirect to 403 page
    def authorize_access
      unless (@recipe.public?  or current_user.present?)
        render file: "#{Rails.root}/public/403.html", layout: false, status: 403
      end
    end

    # before publish, unpublish
    # OK if we are logged (As blog admin)
    # else redirect to 403 page
    def authorize_action
      unless current_user.present?
        render file: "#{Rails.root}/public/403.html", layout: false, status: 403
      end
    end
end
