Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'auth'

  namespace :v1 do
    get 'mileages' => 'mileages#index'
    get 'mileages/graph_data' => 'mileages#graph_data'
    get 'mileages/monthly' => 'mileages#monthly'
    post 'mileages' => 'mileages#create'
    delete 'mileages' => 'mileages#delete'

    put 'settings/update' => 'settings#update'
  end

end
