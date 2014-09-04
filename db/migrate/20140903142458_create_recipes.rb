class CreateRecipes < ActiveRecord::Migration
  def change
    create_table :recipes do |t|
      t.integer :prep_time
      t.string :name
      t.string :instructions
      t.integer :food_value
      t.string :range

      t.timestamps
    end
  end
end
