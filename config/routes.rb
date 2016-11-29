Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      namespace :items do
        get '', to: 'items#index'
        get '/find', to: 'search#show'
        get '/:id', to: 'items#show'
      end

      namespace :merchants do
        get '', to: 'merchants#index'
        get '/:id/customers_with_pending_invoices', to: 'customers_pending_invoices#index'
        get '/:id', to: 'merchants#show'
      end

      #resources :merchants, only: [:index, :show]
      resources :transactions, only: [:index, :show]
      resources :customers, only: [:index, :show]
      resources :invoices, only: [:index, :show]
      #resources :items, only: [:index, :show]
      resources :invoice_items, only: [:index, :show]          
    end
  end
end
