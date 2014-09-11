class CreateUnits < ActiveRecord::Migration
  def change
    create_table :units do |t|
      t.string :long_name
      t.string :name
      t.float :conversion_factor
      t.references :conversion_unit
            
      t.timestamps
    end
    
    add_index :units, :long_name, unique: true
    add_index :units, :name, unique: true
  end
end
