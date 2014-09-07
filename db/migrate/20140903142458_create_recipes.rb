class CreateRecipes < ActiveRecord::Migration
  def change
    create_table :recipes do |t|
      t.integer :prep_time
      t.string :name
      t.text :instructions
      t.integer :food_value
      t.string :range
      t.integer :number_of_portions
      
      t.belongs_to :user, index: true
      t.belongs_to :category, index: false
      
      t.timestamps
    end

    add_index :recipes, :name
  end
end
