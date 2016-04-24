Rails.application.routes.draw do
  resources :pic_comments
  devise_for :users
  resources :pics do
    member do  
      put "like", to: "pics#upvote"
    end 
  end    
  root  "pics#index"
end
