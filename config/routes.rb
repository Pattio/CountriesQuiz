Rails.application.routes.draw do
  get 'countries', to: 'countries#index'
  get 'countries/:id', to: 'countries#show', as: 'country'
  devise_for :users
  root 'game#index'
  match '/' => 'game#guess', via: :post
end
