Rails.application.routes.draw do
  resources :projects, only: %i[show destroy new create index]
  resources :groups, only: %i[show destroy new create index update edit]
  resources :users, only: %i[show update destroy index edit new create]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'users#index'
  get 'log', to: 'sessions#login'
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  get 'logout', to: 'sessions#destroy'
  get 'projects/project_ungrouped', to: 'projects#project_ungrouped'
end
