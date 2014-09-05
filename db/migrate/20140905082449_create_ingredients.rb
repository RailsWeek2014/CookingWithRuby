class CreateIngredients < ActiveRecord::Migration
  def change
    create_table :ingredients do |t|
      t.string :name
      t.integer :kj
      t.float :carbohydrate
      t.float :protein
      t.float :fat
      t.float :roughage
      t.float :default_quantity
      
      t.belongs_to :unit, index: false
            
      t.timestamps
    end
    
    add_index :ingredients, :name, unique: true
  end
end
