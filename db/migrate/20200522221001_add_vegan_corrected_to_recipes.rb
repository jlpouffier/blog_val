class AddVeganCorrectedToRecipes < ActiveRecord::Migration[6.0]
  def change
  	add_column :recipes, :vegan, :boolean, null: false, default: false
  end
end
