Rails.application.routes.draw do
  get 'comment/new'

  get 'comment/create'

  get 'comment/edit'

  get 'comment/list'

  # root route
  root 'recipes#list'

  devise_for :users, controllers: { registrations: 'users/registrations', sessions: 'users/sessions' }

  # recipe routes
  get 'recipes/:id/add_to_cookbook' => 'cookbooks#add'
  get 'recipes/list/:id' => 'recipes#specific_list', as: 'own_recipes'
  get 'recipes/list'
  
  # ingredient routes
  get 'ingredients/new'
  get 'ingredients' => 'recipes#list'
  post 'ingredients' => 'ingredients#create'
  
  # category routes
  get 'categories/new'
  get 'categories' => 'recipes#list'
  post 'categories' => 'categories#create'
  
  # unit routes
  get 'units/new'
  get 'units' => 'recipes#list'
  post 'units' => 'units#create'
  
  # cookbook routes
  get 'cookbooks/add'
  get 'cookbooks/new'
  get 'cookbooks/list', as: "cookbook_list"
  get 'cookbooks/:id/edit'=> "cookbooks#edit"
  get 'cookbooks/:id'=> "cookbooks#show", as: "cookbook"
  get 'cookbooks' => "cookbooks#list", as: "cookbooks"
  post 'cookbooks/add' => 'cookbooks#add_cookbook_entry'
  post 'cookbooks' => 'cookbooks#create'
  patch "cookbooks/:id" => "cookbooks#update"
  delete "cookbooks/:id" => "cookbooks#destroy"

  #search routes
  get 'search/fuzzy'
  get 'search/user'
  get 'search/recipe'
  get 'search/ingredient'
  get 'search/category'
  
  #meal_plans routes
  get 'meal_plans/' => 'meal_plans#week_overview'
  get 'meal_plan/' => 'meal_plans#week_overview'
  get 'meal_plans/new/' => 'meal_plans#new'
  get 'meal_plans/new/:date/:daytime' => 'meal_plans#new', as: 'new_meal_plan'
  get 'meal_plans/create'
  get 'meal_plans/destroy'
  get 'meal_plans/update'
  get 'meal_plans/:date' => 'meal_plans#week_overview', as: 'meal_plans_week'
  get 'meal_plans/:id/edit' => 'meal_plans#edit', as: 'edit_meal_plan'
  get 'meal_plans/ingredient_requirements/:date' => 'meal_plans#ingredient_requirements', as: 'ingredient_requirement'
  get 'meal_plans/ingredient_requirements_pdf/:date' => 'meal_plans#ingredient_requirements_pdf', as: 'ingredient_requirement_pdf'
  
  patch 'meal_plans/:id' => 'meal_plans#update'
  
  post 'meal_plans' => 'meal_plans#create'
  
  #json routes
  get 'json/units'
  get 'json/categories'
  get 'json/ingredients'
  
  #comments routes
  get 'comments/new/:id' => 'comments#new'
  get 'comments/answer_to/:id' => 'comments#answer'
  get 'comments/:id/edit' => 'comments#edit'
  
  post 'comments' => 'comments#create'
  patch 'comments/:id' => 'comments#update'
  delete 'comments/:id' => 'comments#destroy'
  
  resources 'recipes'
#  get 'recipes' => 'recipes#list', as: 'recipes'
#  get 'recipes/new' => 'recipes#new'
#  get "recipes/:id/edit" => "recipes#edit", as: "edit_recipe"
#  get "recipes/:id" => "recipes#show", as: 'recipe'
#  delete "recipes/:id" => "recipes#destroy"
#  post 'recipes' => 'recipes#create'  
#  patch "recipes/:id" => "recipes#update"
  
end
