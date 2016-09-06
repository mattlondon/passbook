Rails.application.routes.draw do
  root :to => 'welcome#index'

  get 'signin', to: 'sessions#new', as: 'sign_in'
  get 'signout', to: 'sessions#destroy', as: 'sign_out'

  resource :sessions
end
