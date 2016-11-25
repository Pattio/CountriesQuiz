Rails.application.routes.draw do
  scope "(:locale)" do
    scope "/admin" do
      get 'index', to: 'admin#index', as: 'dashboard'
      match 'destroy' => 'admin#destroy', via: :delete
      match 'role_change' => 'admin#role_change', via: :patch
    end
    get 'countries', to: 'countries#index'
    get 'countries/:id', to: 'countries#show', as: 'country'
    match '/' => 'game#guess', via: :post
    devise_for :users
    root 'game#index'
  end
end
