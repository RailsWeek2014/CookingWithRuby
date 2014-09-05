class CreatePictures < ActiveRecord::Migration
  def change
    create_table :pictures do |t|
      t.string :picture_path

      t.belongs_to :recipe, index: true

      t.timestamps
    end
  end
end
