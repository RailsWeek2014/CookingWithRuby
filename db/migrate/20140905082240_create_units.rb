class CreateUnits < ActiveRecord::Migration
  def change
    create_table :units do |t|
      t.string :name
      t.string :short_name
            
      t.timestamps
    end
    
    add_index :units, :name, unique: true
    add_index :units, :short_name, unique: true
  end
end
