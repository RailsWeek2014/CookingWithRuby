class CreatePictures < ActiveRecord::Migration
  def change
    create_table :pictures do |t|
      t.string :picture_path

      t.integer :recipe_id

      t.timestamps
    end
  end
end
