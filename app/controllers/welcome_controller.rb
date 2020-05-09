class WelcomeController < ApplicationController
  def index
  	@latest_recipes = Recipe.all.order("created_at DESC").limit(3)
  end
end
