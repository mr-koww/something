Rails.application.routes.draw do
  resources :somethings, only: %i[index create]
end
