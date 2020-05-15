class WelcomeController < ApplicationController
  def index
  	@latest_published_recipes = Recipe.published.order(created_at: :desc).limit(3)
  	@unpublished_recipes = Recipe.unpublished
  	@most_popular_categories = Category.all.order(recipes_count: :desc).limit(4)
  	@random_recipe = Recipe.published.random.first
  end
end
