class Recipe < ApplicationRecord
	validates :title, presence: true
	validates :photo, presence: true
	validates :story, presence: true
	validates :ingredients, presence: true
	validates :complexity, presence: true
	validates :instructions, presence: true
	validates :preparation_time, presence: true

	validates :preparation_time, numericality: { only_integer: true, :greater_than_or_equal_to => 1 }

	validates :complexity, numericality: { only_integer: true, :greater_than_or_equal_to => 1, :less_than_or_equal_to => 3 }

	has_and_belongs_to_many :categories
	has_one_attached :photo

	def self.search(search)
		where("title LIKE ?", "%#{search}%") 
	end
end

