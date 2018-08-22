Rails.application.routes.draw do
  resources :trips, except: [:edit, :update, :destroy]

  get 'api/stats/weekly', to: 'trips#weekly'
  get 'api/stats/monthly', to: 'trips#monthly'

end
