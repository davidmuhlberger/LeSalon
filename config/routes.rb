Rails.application.routes.draw do
  devise_for :sellers
  devise_for :users
end
