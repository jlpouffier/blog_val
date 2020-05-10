class AddPublicToRecipes < ActiveRecord::Migration[6.0]
  def change
  	add_column :recipes, :public, :boolean
  end
end
