module ApplicationHelper
  def visible_recipes
    recipes = Recipe.all.where range: 'public'
    
    if user_signed_in?
      recipes = recipes | (Recipe.all.where range: 'registrated')
      recipes = recipes | current_user.recipes
    end
  end
end
