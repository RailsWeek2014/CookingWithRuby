class JsonController < ApplicationController
  
  def ingredients
    @ingredients = Ingredient.all
    @i = 0
  end
end
