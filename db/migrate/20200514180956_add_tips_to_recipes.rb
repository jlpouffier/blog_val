class AddTipsToRecipes < ActiveRecord::Migration[6.0]
  def change
    add_column :recipes, :tips, :text
  end
end
