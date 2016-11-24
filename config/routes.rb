Rails.application.routes.draw do
  scope "(:locale)" do
    get 'countries', to: 'countries#index'
    get 'countries/:id', to: 'countries#show', as: 'country'
    match '/' => 'game#guess', via: :post
    devise_for :users
    root 'game#index'
  end
end
