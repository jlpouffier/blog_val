class RenameCatogoriesRecipesToCategoriesRecipes < ActiveRecord::Migration[6.0]
  def self.up
    rename_table :catogories_recipes, :categories_recipes
  end

  def self.down
    rename_table :categories_recipes, :catogories_recipes
  end
end