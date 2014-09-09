class CreateBookmarkEntries < ActiveRecord::Migration
  def change
    create_table :cookbook_entries do |t|
      t.belongs_to :cookbook
      t.belongs_to :recipe
    end
      
    add_index :cookbook_entries, ["cookbook_id", "recipe_id"], :unique => true
  end
end
