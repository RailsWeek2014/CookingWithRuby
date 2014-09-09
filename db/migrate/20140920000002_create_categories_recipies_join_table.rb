class CreateCategoriesRecipiesJoinTable < ActiveRecord::Migration
  def change
    create_join_table :categories, :recipes do |t|
      t.index [:category_id, :recipe_id], unique: true
      # t.index [:recipe_id, :category_id]
    end
  end
end
