Rails.application.routes.draw do
  
  get 'ingredients/new'

  get 'ingredients/create'

  # root route
  root 'recipes#list'

  devise_for :users, controllers: { registrations: 'users/registrations' }

  # recipe routes
  get 'recipes/list/:id' => 'recipes#specific_list', as: 'own_recipes'
  get 'recipes/list'
  
  # ingredient routes
  get 'ingredients/new'
  
  resources 'recipes'
#  get 'recipes' => 'recipes#list', as: 'recipes'
#  get 'recipes/new' => 'recipes#new'
#  get "recipes/:id/edit" => "recipes#edit", as: "edit_recipe"
#  get "recipes/:id" => "recipes#show", as: 'recipe'
#  delete "recipes/:id" => "recipes#destroy"
#  post 'recipes' => 'recipes#create'  
#  patch "recipes/:id" => "recipes#update"
  
end
