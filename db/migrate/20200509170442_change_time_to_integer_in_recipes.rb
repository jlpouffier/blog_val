class ChangeTimeToIntegerInRecipes < ActiveRecord::Migration[6.0]
  def change
  	  change_column :recipes, :preparation_time, 'integer USING cast(extract(epoch from current_timestamp) as integer)'
  end
end
