class AddWaitingTimeAndBakingTimeToRecipes < ActiveRecord::Migration[6.0]
  def change
  	add_column :recipes, :waiting_time, :integer
  	add_column :recipes, :baking_time, :integer
  end
end
