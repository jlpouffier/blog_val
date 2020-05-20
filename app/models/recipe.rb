class Recipe < ApplicationRecord
	# Frendly id. Transform things like /recipes/1 into /recipses/gateau-au-chocolat
	extend FriendlyId
  	friendly_id :title, use: :slugged

	# pagination
  	paginates_per 3

  	# full text postgress search
	include PgSearch::Model
	pg_search_scope :search_by_title, 
					against: :title,
					using: { tsearch: { dictionary: 'french' } }

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

    # Convert preparation time into human readable string
	def preparation_time_human
		convert_time_to_human(self.preparation_time)
	end

	# Convert baking time into human readable string
	def baking_time_human
		convert_time_to_human(self.baking_time)
	end

	# Convert waiting time into human readable string
	def waiting_time_human
		convert_time_to_human(self.waiting_time)
	end

	# Convert global time into human readable string
	def global_time_human
		global_time = self.preparation_time.to_i + self.waiting_time.to_i + self.baking_time.to_i
		convert_time_to_human(global_time)
	end

	# Convert complixity time into human readable string
	def complexity_human
		case self.complexity
		when 1
			"Simple"
		when 2
			"Moyen"
		when 3
			"Difficile"
		end
	end
end

# Convert an number of minutes into a human readable time
def convert_time_to_human(integer)
	hours, minutes = integer.to_i.divmod(60)
	if hours == 0
		minutes.to_s + " min"
	elsif minutes == 0
		hours.to_s + "h"
	else
		hours.to_s + "h" + minutes.to_s
	end
end