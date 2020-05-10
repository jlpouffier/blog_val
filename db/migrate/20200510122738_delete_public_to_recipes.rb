class DeletePublicToRecipes < ActiveRecord::Migration[6.0]
  def change
  	remove_column :recipes, :public
  end
end
