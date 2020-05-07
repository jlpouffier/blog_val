class CreateJointTable < ActiveRecord::Migration[6.0]
  def change
    create_table :catogories_recipes, id: false do |t|
      t.belongs_to :category
      t.belongs_to :recipe
    end
  end
end
