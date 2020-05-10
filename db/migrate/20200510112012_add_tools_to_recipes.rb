class AddToolsToRecipes < ActiveRecord::Migration[6.0]
  def change
  	add_column :recipes, :tools, :text
  end
end
