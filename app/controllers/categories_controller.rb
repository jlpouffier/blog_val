class CategoriesController < ApplicationController
  before_action :set_category, only: [:show]

  # GET /categories
  def index
    # Get all categiries orders by title
    @categories = Category.all.order(:title).page params[:page]

    # Set the meta tags of the page. Descirption and keywords include the cateogries
    # TODO: Order the keywords and description by popularity
    set_meta_tags title: 'Catégories',
                  description: 'Toutes les catérories: ' + @categories.map(&:title).join(', ') + ' ...',
                  keywords: @categories.map(&:title).join(', '),
                  og: {
                    title: :title,
                    site_name: :site,
                    url: request.original_url,
                    description: :description,
                    locale: "fr_FR",
                    type: "website"
                  }
  end

  # GET /categories/1
  def show
    # Get all related recipes for that cateogy, ordered by title
    @recipes = @category.recipes.published.order(:title).page params[:page]

    @category.punch(request)

    # Set the meta tags of the page. 
    # Descirption is the stripped down version of the category desciprition (The first 160 char)
    # keywords are the related recipes.
    # TODO: Order the keywords by popularity   
    set_meta_tags title: 'Catégorie: ' + @category.title,
                  description: helpers.no_markdown(@category.description)[0..160],
                  keywords: @recipes.map(&:title).join(', '),
                  og: {
                    title: :title,
                    site_name: :site,
                    image: url_for(@category.photo),
                    url: request.original_url,
                    description: :description,
                    locale: "fr_FR",
                    type: "article",
                    article: {
                      published_time: @category.created_at
                    }
                  }
  end

  private
    def set_category
      @category = Category.friendly.find(params[:id])
    end
end
