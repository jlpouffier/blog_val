class CategoriesRecipe < ApplicationRecord
	belongs_to :recipe
	belongs_to :category, counter_cache: :recipes_count
end
