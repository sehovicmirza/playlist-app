Rails.application.routes.draw do
  devise_for :users
  resources :playlists do
    resources :subscriptions, only: [:create, :destroy]
    resources :items do
      resources :votes, only: [:create]
      delete "votes", :to => "votes#destroy"
    end
  end

  root "playlists#index"
end
