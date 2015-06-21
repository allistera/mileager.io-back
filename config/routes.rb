Rails.application.routes.draw do

  devise_for :users, controllers: { sessions: 'users/sessions' }, defaults: { format: :json }
  root 'application#index'

  namespace :v1 do
    get 'mileages' => 'mileages#index'
    get 'mileages/graph_data' => 'mileages#graph_data'
    get 'mileages/monthly' => 'mileages#monthly'
    post 'mileages' => 'mileages#create'
    delete "mileages/:id" => "mileages#delete"

    get 'settings' => 'settings#index'
  end

end
