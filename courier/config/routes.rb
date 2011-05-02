Courier::Application.routes.draw do
	resources :paquetes

	resources :compania

	resources :facturas

	resources :tipo_pagos

	resources :direccions

	resources :historicos

	resources :ordens

	resources :personas

	resources :empleados

	resources :enviar

	get "courier/index"

	# The priority is based upon order of creation:
	# first created -> highest priority.

	# Sample of regular route:
	#   match 'products/:id' => 'catalog#view'
	# Keep in mind you can assign values other than :controller and :action

	# Sample of named route:
	#   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
	# This route can be invoked with purchase_url(:id => product.id)

	# Sample resource route (maps HTTP verbs to controller actions automatically):
	#   resources :products

	# Sample resource route with options:
	#   resources :products do
	#     member do
	#       get 'short'
	#       post 'toggle'
	#     end
	#
	#     collection do
	#       get 'sold'
	#     end
	#   end

	# Sample resource route with sub-resources:
	#   resources :products do
	#     resources :comments, :sales
	#     resource :seller
	#   end

	# Sample resource route with more complex sub-resources
	#   resources :products do
	#     resources :comments
	#     resources :sales do
	#       get 'recent', :on => :collection
	#     end
	#   end

	# Sample resource route within a namespace:
	#   namespace :admin do
	#     # Directs /admin/products/* to Admin::ProductsController
	#     # (app/controllers/admin/products_controller.rb)
	#     resources :products
	#   end

	match 'contenido', :to => 'courier#contenido', :as => "cont"

	match 'paquetes/new/:id', :to => 'paquetes#new', :via => 'get', :as => "newpa"
	match 'enviar/tipoPago/:id', :to => 'enviar#tipoPago', :via => 'get', :as => "tipoPago"
	match 'gen_xml/:id', :to => 'enviar#gen_xml', :via => 'get', :as => "genxml"

	root :to => "courier#index"
	get 'contenido' => 'courier#contenido'

	# match '*a', :to => 'errors#routing'

	# You can have the root of your site routed with "root"
	# just remember to delete public/index.html.
	# root :to => "welcome#index"
	match ':controller(/:action(/:id(.:format)))'
# See how all your routes lay out with "rake routes"

# This is a legacy wild controller route that's not recommended for RESTful applications.
# Note: This route will make all actions in every controller accessible via GET requests.
# match ':controller(/:action(/:id(.:format)))'
end
