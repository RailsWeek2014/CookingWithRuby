class InsertTestData < ActiveRecord::Migration
  def change
    User.create name: "Test User", username: "test_user", picture: nil, sex: "m",
      birth_date: nil, weight: nil, role: nil, email: "test@awesome.test",
      encrypted_password: "$2a$10$/i0WxBVrJhpD078lXbk3De/CtK.AulQsRgVMH.PVszdfRESRmATWu"
    
    Ingredient.create name: "Wasser"
    Ingredient.create name: "Zucker"
    
    Unit.create name: "Liter", short_name: "l"
    Unit.create name: "Gramm", short_name: "g"
    
    Recipe.create name: "Heißes Zuckerwasser", prep_time: 15, 
      instructions: "Wasser zum Kochen bringen & Zucker einrühren",
      range: "public", user_id: 1
    
    Quantity.create quantity: 1.0, unit_id: 1, ingredient_id: 1, recipe_id: 1
    Quantity.create quantity: 100.0, unit_id: 2, ingredient_id: 2, recipe_id: 1
    
    Recipe.create name: "Registrated Test", prep_time: 1, instructions: "", range: "registrated"
    Recipe.create name: "Private Test", prep_time: 1, instructions: "", range: "private"
    Recipe.create name: "Public Test", prep_time: 1, instructions: "", range: "public"
  end
end