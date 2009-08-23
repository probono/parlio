ActionController::Routing::Routes.draw do |map|
  # The priority is based upon order of creation: first created -> highest priority.

  # Sample of regular route:
  #   map.connect 'products/:id', :controller => 'catalog', :action => 'view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   map.purchase 'products/:id/purchase', :controller => 'catalog', :action => 'purchase'
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  
  map.activity  '/activity',    :controller => 'activity', :action => 'index'

  map.initiatives_by_tag  '/activity/initiatives/by_tag/:tag',    :controller => 'taggings', :action => 'show'
  
  map.search    '/search',      :controller => 'search', :action => 'search'
  
  map.resources :parties, :member => {:initiatives => :get, :interventions => :get, :commissions => :get} 
  map.resources :topics, :path_prefix => 'activity'
  map.resources :initiatives, :path_prefix => 'activity'            
  map.resources :interventions, :path_prefix => 'activity' 
  map.interventions_by_session  '/activity/interventions/session/:session_date' , :controller => 'interventions', :action => 'by_session_date'
  map.resources :commisions, :path_prefix => 'activity'
  
  map.resources :parliamentarians, :member => {:initiatives => :get, :interventions => :get, :commisions => :get} 

  # Sample resource route with options:
  #   map.resources :products, :member => { :short => :get, :toggle => :post }, :collection => { :sold => :get }

  # Sample resource route with sub-resources:
  #   map.resources :products, :has_many => [ :comments, :sales ], :has_one => :seller
  
  # Sample resource route with more complex sub-resources
  #   map.resources :products do |products|
  #     products.resources :comments
  #     products.resources :sales, :collection => { :recent => :get }
  #   end

  # Sample resource route within a namespace:
  #   map.namespace :admin do |admin|
  #     # Directs /admin/products/* to Admin::ProductsController (app/controllers/admin/products_controller.rb)
  #     admin.resources :products
  #   end

  # You can have the root of your site routed with map.root -- just remember to delete public/index.html.
  map.with_options(:controller => 'page') do |page|
    ["contact", "about", "legal"].each do |name|                    
      page.send name,  name, :action => name
    end
  end 


  map.root :controller => "home"

end
