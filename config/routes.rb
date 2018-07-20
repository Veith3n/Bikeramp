Rails.application.routes.draw do
  resources :trips, except: [:edit, :update, :destroy]

  get 'weekly', to: 'routes#stats#weekly'
  get 'monthly', to: 'routes#stats#monthly'

end
