class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string :name

      t.timestamps
      
    end
    
    create_table :categories_recipes, id: false do |t|
      t.belongs_to :category
      t.belongs_to :recipe
    end
  end
end
