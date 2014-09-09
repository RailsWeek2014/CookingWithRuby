class JsonController < ApplicationController
  skip_load_and_authorize_resource
  
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

  def units
    @type = "unit"
    @list = Unit.all
    @i = 0
    
    render 'list'
  end
end
