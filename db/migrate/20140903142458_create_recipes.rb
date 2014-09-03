class CreateRecipes < ActiveRecord::Migration
  def change
    create_table :recipes do |t|
      t.integer :prep_time
      t.string :name
      t.string :instructions
      t.string :food_value
      t.string :integer
      t.string :range

      t.timestamps
    end
  end
end
