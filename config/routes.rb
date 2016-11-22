Rails.application.routes.draw do
  devise_for :users
  root 'game#index'
  match '/' => 'game#guess', via: :post
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
