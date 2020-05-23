class WelcomeController < ApplicationController
  def index
    # Last 3 publish recipes
  	@latest_published_recipes = Recipe.published.order(created_at: :desc).limit(3)

    # The unpublished recipes
  	@unpublished_recipes = Recipe.unpublished

    # The 4 most popular cateogries (By recipes_count)
  	@most_popular_categories = Category.all.order(recipes_count: :desc).limit(4)

    # One random recipe
  	@random_recipe = Recipe.published.random.first

    # Set the meta tags of the page. 
    # Keywords include everything displayed on the page : The last published recipes, the most popular categories
    set_meta_tags description: "Youpi Poutchi blog" ,
              		keywords: @latest_published_recipes.map(&:title).join(', ') + 
                            ', ' + 
                            @most_popular_categories.map(&:title).join(', '),
                  og: {
                    title: :title,
                    site_name: :site,
                    url: request.original_url,
                    description: :description,
                    locale: "fr_FR",
                    type: "website"
                  }
  end
end
