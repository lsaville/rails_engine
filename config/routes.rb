Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      namespace :merchants do
        get 'find', to: 'search#show'
        get 'find_all', to: 'search#index'
        get 'random', to: 'random#show'
        get 'most_items', to: 'most_items#index'
      end

      namespace :customers do
        get 'find', to: 'search#show'
        get 'find_all', to: 'search#index'
        get 'random', to: 'random#show'
      end

      namespace :transactions do
        get 'find', to: 'search#show'
        get 'find_all', to: 'search#index'
        get 'random', to: 'random#show'
      end

      namespace :items do
        get '', to: 'items#index'
        get 'find', to: 'search#show'
        get 'find_all', to: 'search#index'
        get 'random', to: 'random#show'
        get '/:id/invoice_items', to: 'invoice_items#index'
        get '/:id/merchant', to: 'merchants#index'
        get ':id', to: 'items#show'
      end

      namespace :invoices do
        get '', to: 'invoices#index'
        get 'find', to: 'search#show'
        get 'find_all', to: 'search#index'
        get 'random', to: 'random#show'
        get '/:id/transactions', to: 'transactions#index', as: 'transactions'
        get '/:id/invoice_items', to: 'invoice_items#index', as: 'invoice_items'
        get '/:id/items', to: 'items#index', as: 'items'
        get '/:id/customer', to: 'customers#index', as: 'customer'
        get '/:id/merchant', to: 'merchants#index', as: 'merchant'
        get ':id', to: 'invoices#show'
      end

      namespace :invoice_items do
        get '', to: 'invoice_items#index'
        get 'find', to: 'search#show'
        get 'find_all', to: 'search#index'
        get 'random', to: 'random#show'
        get '/:id/invoice', to: 'invoices#index'
        get '/:id/item', to: 'items#index'
        get ':id', to: 'invoice_items#show'
      end

      namespace :merchants do
        get '', to: 'merchants#index'
        get '/:id/revenue', to: 'revenue#index'
        get '/:id/customers_with_pending_invoices', to: 'customers_pending_invoices#index'
        get '/:id', to: 'merchants#show'
      end

      resources :transactions, only: [:index, :show]
      resources :customers, only: [:index, :show]
    end
  end
end
