class Recipe < ApplicationRecord
	has_and_belongs_to_many :categories
	has_one_attached :photo

	def self.search(search)
		search_fields = ["title"]
	end
end

