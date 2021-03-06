# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
password = "12345678"

u1 = User.create name: "Test User", username: "test_user", picture: nil, sex: "m", birth_date: nil, weight: nil, role: 'a', email: "test@awesome.com", password: password, password_confirmation: password
    
um = Unit.create long_name: "Milliliter", name: "ml"
ug = Unit.create long_name: "Gramm", name: "g"
us = Unit.create long_name: "Stück", name: "St"

iw = Ingredient.create name: "Wasser", kj: 0, carbohydrate: 0.0, protein: 0.0, fat: 0.0, roughage: 0.0, default_quantity: 100.0, unit: um
iz = Ingredient.create name: "Zucker", kj: 168, carbohydrate: 100.0, protein: 0.0, fat: 0.0, roughage: 0.0, default_quantity: 100.0, unit: ug
im = Ingredient.create name: "Mehl", kj: 1464, carbohydrate: 80.0, protein: 6.0, fat: 1.4, roughage: 0.0, default_quantity: 100.0, unit: ug
ie = Ingredient.create name: "Ei", kj: 1288, carbohydrate: 3.6, protein: 16.0, fat: 27.0, roughage: 0.0, default_quantity: 100.0, unit: us

ck = Category.create name: "Kuchen"
cf = Category.create name: "Frühstück"
cm = Category.create name: "Mittagessen"
cc = Category.create name: "Chinesisch"

r1 = Recipe.create name: "Heißes Zuckerwasser", prep_time: 15, 
  instructions: "Wasser zum Kochen bringen & Zucker einrühren",
  range: "public", number_of_portions: 2, user: u1
  
r1.categories << cf

Quantity.create quantity: 1.0, unit: um, ingredient: iw, recipe: r1
Quantity.create quantity: 100.0, unit: ug, ingredient: iz, recipe: r1

Recipe.create name: "Registrated Test", prep_time: 1, instructions: "a", range: "registrated", user: u1, number_of_portions: 2
Recipe.create name: "Private Test", prep_time: 1, instructions: "b", range: "private", user: u1, number_of_portions: 2
Recipe.create name: "Public Test", prep_time: 1, instructions: "c", range: "public", user: u1, number_of_portions: 2

Activity.create name: "Radfahren", kj: 1040
Activity.create name: "Fußball spielen", kj: 2240
Activity.create name: "Liegen", kj: 300
Activity.create name: "Sitzen", kj: 300
Activity.create name: "Laufen (langsam - 5 km/h)", kj: 1532
