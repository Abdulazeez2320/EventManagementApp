Rails.application.routes.draw do
  authenticated :user do
    root 'events#index', as: :authenticated_root
  end
  root to: redirect('/users/sign_in')  # Redirect to login page for non-authenticated users
  devise_for :users
  # resources :events do
  #   resources :comments
  # end
  resources :events do
    resources :comments
    member do
      post 'rsvp'
      delete 'cancel_rsvp'
    end
  end
end
