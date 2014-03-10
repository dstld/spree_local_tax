Spree::Core::Engine.routes.draw do
  namespace :admin do
    resources :local_taxes
    match '/reports/local_tax' => 'admin/reports#local_tax', :via => [:get, :post], :as => 'local_tax_admin_reports'
    match '/reports/orders_local_tax' => 'admin/reports#orders_local_tax', :via => [:get, :post], :as => 'orders_local_tax_admin_reports'
  end
end
