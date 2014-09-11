Rails.application.routes.draw do
  
  devise_for :users, controllers: { registrations: 'users/registrations', sessions: 'users/sessions', 
    omniauth_callbacks: 'users/omniauth_callbacks' }
  # admin routes
  get 'admin/' => 'admin/users#list'
  get 'admin/users' => 'admin/users#list'
  patch 'admin/users/:id/grand/:role' => 'admin/users#update'
  
  # root route
  root 'recipes#list'

  # recipe routes
  get 'recipes/list/:user_id' => 'recipes#specific_list', as: 'own_recipes'
  get 'recipes/list'
  post 'recipes/:id/rate' => 'recipes#rate'
  
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
  
  # cookbook-entry routes
  get 'recipes/:id/add_to_cookbook' => 'cookbooks/entries#new'
  post 'cookbooks/:id/create_entry' => 'cookbooks/entries#create'
  delete 'cookbooks/entry/:id' => 'cookbooks/entries#destroy'
  
  # cookbook routes
  get 'cookbooks/new'
  get 'cookbooks/list', as: "cookbook_list"
  get 'cookbooks/:id/edit'=> "cookbooks#edit"
  get 'cookbooks/:id'=> "cookbooks#show", as: "cookbook"
  get 'cookbooks' => "cookbooks#list", as: "cookbooks"
  post 'cookbooks' => 'cookbooks#create'
  patch "cookbooks/:id" => "cookbooks#update"
  delete "cookbooks/:id" => "cookbooks#destroy"
  
  #search routes
  get 'search/search'
  get 'search/advanced_search'
  
  #meal_plans routes
  get 'meal_plans/' => 'meal_plans#week_overview'
  get 'meal_plans/new/' => 'meal_plans#new'
  get 'meal_plans/new/:date/:daytime' => 'meal_plans#new', as: 'new_meal_plan'
  post 'meal_plans/create'
  get 'meal_plans/update'
  get 'meal_plans/:date' => 'meal_plans#week_overview', as: 'meal_plans_week'
  get 'meal_plans/:id/edit' => 'meal_plans#edit', as: 'edit_meal_plan'
  get 'meal_plans/ingredient_requirements/:date' => 'meal_plans#ingredient_requirements', as: 'ingredient_requirement'
  get 'meal_plans/ingredient_requirements_pdf/:date' => 'meal_plans#ingredient_requirements_pdf', as: 'ingredient_requirement_pdf'
  
  patch 'meal_plan/:id' => 'meal_plans#update', as: 'meal_plan'
  post 'meal_plans' => 'meal_plans#create'  
  delete 'meal_plans/:id' => 'meal_plans#destroy', as: 'delete_meal_plan'
  
  #activity_plans routes
  get 'activity_plans/new'
  get 'activity_plans/new/:date' => 'activity_plans#new', as: 'new_activity_plan_week'
  get 'activity_plans/overview'

  get 'activity_plans/:date' => 'activity_plans#overview', as: 'activity_plans_week'
  
  post 'activity_plans' => 'activity_plans#create'
  
  get 'activity_plans/:id/edit' => 'activity_plans#edit'

  post 'activity_plans/create'
  delete 'activity_plans/:id' => 'activity_plans#destroy'
  patch 'activity_plans/:id' => 'activity_plans#update'
  
  #activity routes
  get 'activities/new'
  post 'activities' => 'activities#create'
  
  #json routes
  get 'json/units'
  get 'json/categories'
  get 'json/ingredients'
  get 'json/activities'
  
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
