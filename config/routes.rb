Rails.application.routes.draw do
  
  # root route
  root 'recipes#list'

  devise_for :users, controllers: { registrations: 'users/registrations' }

  # recipe routes
  get 'recipes' => 'recipes#list', as: 'recipes'
  get 'recipes/new' => 'recipes#new'
  get "recipes/:id/edit" => "recipes#edit", as: "edit_recipe"
  get "recipes/:id" => "recipes#show", as: 'recipe'
  delete "recipes/:id" => "recipes#destroy"
  post 'recipes' => 'recipes#create'  
  patch "recipes/:id" => "recipes#update"
  
end
