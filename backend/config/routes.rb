Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
     resources :devices, only: %i[index create destroy]
    end 
  end 
end
