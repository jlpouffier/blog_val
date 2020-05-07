class CreateRecipes < ActiveRecord::Migration[6.0]
  def change
    create_table :recipes do |t|
      t.string :title
      t.text :story
      t.text :instructions
      t.text :ingredients
      t.integer :complexity
      t.time :time

      t.timestamps
    end
  end
end
