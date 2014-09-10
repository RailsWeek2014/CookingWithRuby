class CreateActivityPlans < ActiveRecord::Migration
  def change
    create_table :activity_plans do |t|
      t.date :date
      t.integer :repetitions

      t.belongs_to :user
      t.belongs_to :activity
      
      t.timestamps
    end
  end
end
