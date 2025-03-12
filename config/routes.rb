# config/routes.rb
Rails.application.routes.draw do
  root "resources#index"

  # Authentication
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"

  # Registration
  get "/signup", to: "registrations#new"
  post "/signup", to: "registrations#create"

  # User profile and activities
  resources :users, only: [ :index, :edit, :update ] do
    collection do
      get "search"
    end
    member do
      get "my_loans"
      get "my_fines"
    end
  end


  resources :resources do
    collection do
      get "search"
    end
  end

  resources :reservations, only: [ :index, :create ] do
    member do
      patch "approve"
      patch "reject"
    end
  end

  resources :loans do
    member do
      patch "return"
      patch "close"
    end
    collection do
      get "overdue"
      get "outstanding"
      get "past"
    end
  end

  resources :fines, only: [ :index, :show ] do
    member do
      patch "pay"
      patch "collect"
    end
  end


  namespace :api do
    namespace :v1 do
      resources :resources, only: [ :index, :show ] do
        collection do
          get "search"
        end
      end
    end
  end
end
