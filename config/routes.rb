Rails.application.routes.draw do
  scope "(:locale)", locale: /#{I18n.available_locales.join("|")}/ do
    get 'clicker/click'
    get 'clicker/level_up'
    post 'clicker/click'
    get 'clicker/level_up'
    root 'session#login'   
    get 'clicker/index'  
    post 'session/create'     
    get 'session/logout' 
    get 'session/login'
    resources :users, only: %i[new index edit create update destroy]
end 
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
