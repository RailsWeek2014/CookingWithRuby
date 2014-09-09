class InsertTestData < ActiveRecord::Migration
  def change
    User.create name: "Test User", username: "test_user", picture: nil, sex: "m", birth_date: nil, weight: nil, role: nil, email: "test@awesome.com", encrypted_password: "$2a$10$/i0WxBVrJhpD078lXbk3De/CtK.AulQsRgVMH.PVszdfRESRmATWu"
    
    Ingredient.create name: "Wasser"
    Ingredient.create name: "Zucker"
    
    Unit.create long_name: "Milliliter", name: "ml"
    Unit.create long_name: "Gramm", name: "g"
    Unit.create long_name: "Stück", name: "St"
    
    Recipe.create name: "Heißes Zuckerwasser", prep_time: 15, 
      instructions: "Wasser zum Kochen bringen & Zucker einrühren",
      range: "public", user_id: 1
    
    Quantity.create quantity: 1.0, unit_id: 1, ingredient_id: 1, recipe_id: 1
    Quantity.create quantity: 100.0, unit_id: 2, ingredient_id: 2, recipe_id: 1
    
    Recipe.create name: "Registrated Test", prep_time: 1, instructions: "a", range: "registrated", user_id: 1
    Recipe.create name: "Private Test", prep_time: 1, instructions: "b", range: "private", user_id: 1
    Recipe.create name: "Public Test", prep_time: 1, instructions: "c", range: "public", user_id: 1

    Category.create name: "Kuchen"
    Category.create name: "KeinKuchen"
  end
end