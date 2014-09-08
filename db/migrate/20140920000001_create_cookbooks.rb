class CreateCookbooks < ActiveRecord::Migration
  def change
    create_table :cookbooks do |t|
      t.string :name

      belongs_to :user
      t.timestamps
    end
    
    create_table :cookbook_entries do |t|
        t.belongs_to :cookbook
        t.belongs_to :recipe
      end
      
    add_index :cookbook_entries, ["cookbook_id", "recipe_id"], :unique => true

  end
end
