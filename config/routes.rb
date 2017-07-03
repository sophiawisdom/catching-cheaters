Rails.application.routes.draw do
  get '/product/index' => 'product#index'
  get '/product/show' => 'product#show'
  get '/artist/index' => 'artist#index'
  get '/artist/:id' => 'artist#show'
  get '/' => 'artist#index'
# begin  resources :product do

# end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
