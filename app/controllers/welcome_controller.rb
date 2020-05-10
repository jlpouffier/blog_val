class WelcomeController < ApplicationController
  def index
  	@latest_published_recipes = Recipe.published.order("created_at DESC").limit(6)
  	@unpublished_recipes = Recipe.unpublished.order("created_at DESC")
  end
end
