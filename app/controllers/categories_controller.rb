class CategoriesController < ApplicationController
  before_action :set_category, only: [:show]

  # GET /categories
  def index
    # Get all categiries orders by title
    @categories = Category.all.order(:title)

    # Set the meta tags of the page. Descirption and keywords include to first 20 cateogries
    # TODO: Order the keywords and description by popularity    
    end
    set_meta_tags title: 'Catégories',
                  description: 'Toutes les catérories: ' + @categories.limit(20).map(&:title).join(', ') + ' ...',
                  keywords: @categories.limit(20).map(&:title).join(', ')
  end

  # GET /categories/1
  def show
    # Get all related recipes for that cateogy, ordered by title
    @recipes = @category.recipes.published.order(:title)

    # Set the meta tags of the page. 
    # Descirption is the stripped down version of the category desciprition (The first 160 char)
    # keywords are the first 20 related recipes.
    # TODO: Order the keywords by popularity   
    set_meta_tags title: 'Catégorie: ' + @category.title,
                  description: helpers.no_markdown(@category.description)[0..160],
                  keywords: @recipes.limit(20).map(&:title).join(', ')
  end

  private
    def set_category
      @category = Category.friendly.find(params[:id])
    end
end
