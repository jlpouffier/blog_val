class AddPublicCorrectedToRecipes < ActiveRecord::Migration[6.0]
  def change
  	add_column :recipes, :public, :boolean, null: false, default: false
  end
end
