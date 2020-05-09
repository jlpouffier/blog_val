class ChangeTimeToIntegerInRecipes < ActiveRecord::Migration[6.0]
  def change
  	  change_column :recipes, :preparation_time, :integer
  end
end
