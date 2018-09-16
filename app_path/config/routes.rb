Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/about_us', to: 'home#about_us', as: 'about_us'
  get '/image', to: 'home#image', as: 'image'
  root 'home#welcome'
end
