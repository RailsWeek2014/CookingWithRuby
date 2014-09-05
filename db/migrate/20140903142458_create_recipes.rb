class CreateRecipes < ActiveRecord::Migration
  def change
    create_table :recipes do |t|
      t.integer :prep_time
      t.string :name
      t.text :instructions
      t.integer :food_value
      t.string :range
      
      t.belongs_to :user, index: true
      
      t.timestamps
    end

    add_index :recipes, :name
  end
end
