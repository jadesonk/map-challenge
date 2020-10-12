Rails.application.routes.draw do
  root to: 'shops#index'
  post '/shops/filter', to: 'shops#filter', as: 'shops_filter'
end
