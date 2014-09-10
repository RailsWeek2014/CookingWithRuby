class CreateIdentities < ActiveRecord::Migration
  def change
    create_table :identities do |t|
      t.integer :user_id
      t.string :provider
      t.string :uid
      t.string :token
      t.string :secret
      t.string :profile_page
      
      t.timestamps
      
      t.belongs_to :user
    end
  end
end
