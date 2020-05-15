class AddIdToCategoriesRecipes < ActiveRecord::Migration[6.0]
  def change
  	add_column :categories_recipes, :id, :primary_key
  end
end
