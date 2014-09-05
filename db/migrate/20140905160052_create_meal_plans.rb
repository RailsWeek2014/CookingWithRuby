class CreateMealPlans < ActiveRecord::Migration
  def change
    create_table :meal_plans do |t|
      t.date :date
      t.string :daytime

      t.belongs_to :user
      t.belongs_to :recipe
      
      t.timestamps
    end
  end
end
