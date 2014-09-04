class CreateRecipes < ActiveRecord::Migration
  def change
    create_table :recipes do |t|
      t.integer :prep_time
      t.string :name
      t.text :instructions
      t.integer :food_value
      t.string :range
      
      t.integer :user_id

      t.timestamps
    end
  end
end
