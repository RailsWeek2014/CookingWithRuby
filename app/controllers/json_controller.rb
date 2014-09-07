class JsonController < ApplicationController
  
  def ingredients
    @type = "ingredient"
    @list = Ingredient.all
    @i = 0

    render 'list'
  end
  
  def categories
    @type = "category"
    @list = Category.all
    @i = 0
    
    render 'list'
  end
end
