class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string :name, uniqueness: true

      t.timestamps
      
    end
    
    create_table :recipe_categories do |t|
      t.belongs_to :category
      t.belongs_to :recipe
    end
    
    add_index :recipe_categories, ["category_id", "recipe_id"], :unique => true
  end
end
