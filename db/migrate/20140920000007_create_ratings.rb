class CreateRatings < ActiveRecord::Migration
  def change
    create_table :ratings do |t|
      t.integer :user_id
      t.integer :recipe_id
      t.float :rating

      t.belongs_to :user
      t.belongs_to :recipe, index: true
      
      t.timestamps
    end
  end
end
