class ChangeTimeName < ActiveRecord::Migration[6.0]
  def change
  	rename_column :recipes, :time, :preparation_time
  end
end
