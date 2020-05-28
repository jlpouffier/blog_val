class Recipe < ApplicationRecord
	# Frendly id. Transform things like /recipes/1 into /recipses/gateau-au-chocolat
	extend FriendlyId
  	friendly_id :title, use: :slugged

	# pagination (4 lines of 3)
  	paginates_per 12
  	
  	# full text postgress search
	include PgSearch::Model
	pg_search_scope :search_by_title, 
					against: :title,
					using: { tsearch: { dictionary: 'french' } }

	# Hit tracker
	acts_as_punchable

	# has many though relation with category
	has_many :categories_recipe, dependent: :destroy
	has_many :categories, through: :categories_recipe

	# ActiveStorage photo attachement
	has_one_attached :photo

	# Validation
	validates :title, presence: true
	validates :photo, presence: true
	validates :story, presence: true
	validates :ingredients, presence: true
	validates :complexity, presence: true
	validates :instructions, presence: true
	validates :preparation_time, presence: true
	validates :preparation_time, numericality: { only_integer: true, :greater_than_or_equal_to => 1 }
	validates :complexity, numericality: { only_integer: true, :greater_than_or_equal_to => 1, :less_than_or_equal_to => 3 }

	# Scope definition
	scope :published, -> { where(public: true) }
	scope :unpublished, -> { where(public: false) }

	# Give on random item
	def self.random
		offset(rand(count))
    end
end
