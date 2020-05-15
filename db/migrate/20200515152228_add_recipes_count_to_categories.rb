class AddRecipesCountToCategories < ActiveRecord::Migration[6.0]
  def change
    add_column :categories, :recipes_count, :integer
  end
end
