class Category < ApplicationRecord
	has_many :categories_recipe, dependent: :destroy
	has_many :recipes, through: :categories_recipe

	has_one_attached :photo
end
