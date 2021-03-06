class Category < ApplicationRecord
	# Frendly id. Transform things like /categories/1 into /cateogries/vegan
	extend FriendlyId
	friendly_id :title, use: :slugged

	# Pagination (3 lines of 4)
	paginates_per 12

	# Hit tracker
	acts_as_punchable

	# has many though relation with recipes
	has_many :categories_recipe, dependent: :destroy
	has_many :recipes, through: :categories_recipe
	
	# ActiveStorage photo attachement
	has_one_attached :photo

	# Validation
	validates :title, presence: true
	validates :description, presence: true
	validates :photo, presence: true
end
