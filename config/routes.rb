Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
 root to: 'toppages#index'
 
 get 'login', to: 'sessions#new'
 post 'login', to: 'sessions#create'
 delete 'logout', to: 'sessions#destroy'
 
 get 'signup', to: 'users#new'
 get 'master/:id', to: 'users#master', as: 'master'

 resources :users, only: [:index, :show, :new, :create] do
   member do
     get :likes
   end
 end
 get 'search', to: 'rules#search'
 resources :rules, only: [:index, :new, :create, :edit, :update, :destroy]
 resources :favorites, only: [:create, :destroy]
end
