class Recipe < ApplicationRecord
	include PgSearch::Model
	pg_search_scope :search_by_title, 
					against: :title,
					using: { tsearch: { dictionary: 'french' } }

	has_many :categories_recipe, dependent: :destroy
	has_many :categories, through: :categories_recipe
	has_one_attached :photo

	validates :title, presence: true
	validates :photo, presence: true
	validates :story, presence: true
	validates :ingredients, presence: true
	validates :complexity, presence: true
	validates :instructions, presence: true
	validates :preparation_time, presence: true
	validates :preparation_time, numericality: { only_integer: true, :greater_than_or_equal_to => 1 }
	validates :complexity, numericality: { only_integer: true, :greater_than_or_equal_to => 1, :less_than_or_equal_to => 3 }

	scope :published, -> { where(public: true) }
	scope :unpublished, -> { where(public: false) }

	def self.random
		offset(rand(count))
    end

	def preparation_time_human
		convert_time_to_human(self.preparation_time)
	end

	def baking_time_human
		convert_time_to_human(self.baking_time)
	end

	def waiting_time_human
		convert_time_to_human(self.waiting_time)
	end

	def global_time_human
		global_time = self.preparation_time.to_i + self.waiting_time.to_i + self.baking_time.to_i
		convert_time_to_human(global_time)
	end

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