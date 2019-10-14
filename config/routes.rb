Rails.application.routes.draw do
  resources :user_loads do
    collection { post :import}
  end
  resources :menus
  devise_for :users
  get 'home/show' => 'home#show'
  get 'meals/collected' => 'meals#collected'
  get 'meals/delivered' => 'meals#delivered'
  get 'meals/showimage' => 'meals#showimage'
  get 'meals/list' => 'meals#list'
  get 'meals/selected' => 'meals#selected'
  get 'meals/display' => 'meals#display'
  resources :meals
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'meals#list'
end
