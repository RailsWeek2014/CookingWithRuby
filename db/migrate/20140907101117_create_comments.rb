class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.text :message
      t.boolean :pinned

      t.references :answer_to
            
      t.belongs_to :user, index: false
      t.belongs_to :recipe, index: true

      t.timestamps
    end
  end
end
