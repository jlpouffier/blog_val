class Category < ApplicationRecord
	has_and_belongs_to_many :recipes
	has_one_attached :photo
end
