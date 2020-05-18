class CategoriesController < ApplicationController
  before_action :set_category, only: [:show]

  # GET /categories
  def index
    @categories = Category.all.order(:title)
    set_meta_tags title: 'Catégories',
                  description: 'Toutes les catérories: ' + @categories.limit(20).map(&:title).join(', ') + ' ...',
                  keywords: @categories.limit(20).map(&:title).join(', ')
  end

  # GET /categories/1
  def show
    @recipes = @category.recipes.published.order(:title)
    set_meta_tags title: 'Catégorie: ' + @category.title,
                  description: helpers.no_markdown(@category.description)[0..160],
                  keywords: @recipes.limit(20).map(&:title).join(', ')
  end

  private
    def set_category
      @category = Category.friendly.find(params[:id])
    end
end
