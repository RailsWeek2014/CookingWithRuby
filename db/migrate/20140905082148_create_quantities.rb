class CreateQuantities < ActiveRecord::Migration
  def change
    create_table :quantities do |t|
      t.float :quantity

      t.belongs_to :recipe, index: true
      t.belongs_to :ingredient, index: true
      t.belongs_to :unit, index: false
      
      t.timestamps
    end
  end
end
