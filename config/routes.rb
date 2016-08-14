Rails.application.routes.draw do
  namespace :v1 do
    resources :cargos, only: [:create, :show], defaults: { format: :json } do
    end

    resources :ships, only: [:create, :show], defaults: { format: :json } do
    end

    namespace :port do
      resources :opening_locations, only: [:show, :create], defaults: { format: :json } do
        member do
          get :find_cargos
          get :find_ships
        end
      end
    end
  end
end
