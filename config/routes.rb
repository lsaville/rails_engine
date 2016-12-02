Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      namespace :merchants do
        get '', to: 'merchants#index'
        get 'find', to: 'search#show'
        get 'find_all', to: 'search#index'
        get 'random', to: 'random#show'
        get 'most_items', to: 'most_items#index'
        get 'most_revenue', to: 'most_revenue#index'
        get 'revenue', to: 'all_merchants_revenue#show'
        get ':id/revenue', to: 'revenue#show'
        get ':id/items', to: 'items#index'
        get ':id/invoices', to: 'invoices#index'
        get ':id/favorite_customer', to: 'favorite#show'
        get ':id/customers_with_pending_invoices', to: 'customers_pending_invoices#index'
        get ':id', to: 'merchants#show'
      end

      namespace :customers do
        get '', to: 'customers#index'
        get 'find', to: 'search#show'
        get 'find_all', to: 'search#index'
        get 'random', to: 'random#show'
        get ':id/favorite_merchant', to: 'favorite#index'
        get ':id/invoices', to: 'invoices#index'
        get ':id/transactions', to: 'transactions#index'
        get ':id', to: 'customers#show'
      end

      namespace :transactions do
        get '', to: 'transactions#index'
        get 'find', to: 'search#show'
        get 'find_all', to: 'search#index'
        get 'random', to: 'random#show'
        get ':id/invoice', to: 'invoice#show'
        get ':id', to: 'transactions#show'
      end

      namespace :items do
        get '', to: 'items#index'
        get 'find', to: 'search#show'
        get 'find_all', to: 'search#index'
        get 'random', to: 'random#show'
        get 'most_revenue', to: 'most_revenue#index'
        get 'most_items', to: 'most_items#index'
        get ':id/invoice_items', to: 'invoice_items#index'
        get ':id/merchant', to: 'merchant#show'
        get ':id/best_day', to: 'best_day#show'
        get ':id', to: 'items#show'
      end

      namespace :invoices do
        get '', to: 'invoices#index'
        get 'find', to: 'search#show'
        get 'find_all', to: 'search#index'
        get 'random', to: 'random#show'
        get ':id/transactions', to: 'transactions#index'
        get ':id/invoice_items', to: 'invoice_items#index'
        get ':id/items', to: 'items#index'
        get ':id/customer', to: 'customer#index'
        get ':id/merchant', to: 'merchant#index'
        get ':id', to: 'invoices#show'
      end

      namespace :invoice_items do
        get '', to: 'invoice_items#index'
        get 'find', to: 'search#show'
        get 'find_all', to: 'search#index'
        get 'random', to: 'random#show'
        get ':id/invoice', to: 'invoice#index'
        get ':id/item', to: 'item#index'
        get ':id', to: 'invoice_items#show'
      end
    end
  end
end
