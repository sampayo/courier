Courier::Application.routes.draw do

  scope "(:locale)", :locale => /es|en-US|en/ do
    resources :direccions

    resources :paquetes

    resources :compania

    resources :facturas

    resources :tipo_pagos

    resources :historicos

    resources :ordens

    resources :personas

    resources :empleados

    resources :enviar

    resources :despachar

    resources :recolectar

    resources :admin

    resources :service

  end

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

  # Redirecciona a la pagina contenido como cont.
  match '/:locale/contenido', :to => 'courier#contenido', :as => "cont"

  match '/:locale/seguimiento/', :to => 'courier#seguimiento', :as => "seg"

  match '/:locale/empleado/', :to => 'admin#empleados', :as => "emple"

  match '/:locale/admin/', :to => 'admin#index', :as => "adm"

  # Crea el Url para los paquetes, llamando al metodo paquetes.new, y lo manda como get.
  match 'paquetes/new/:id', :to => 'paquetes#new', :via => 'get', :as => "newpa"

  # crea el url para los despachadores donde pueden asignar rutas a los recolectores
  match '/:locale/despachar', :to => 'despachar#index', :as => "despachador"

  # crea ruta con la informacion de rutas asignadas dependiendo del recolector
  match ':locale/ruta/:id', :to => 'despachar#ver', :as => "ver"

  #lista de recolectores y estatus
  match ':locale/recolectores/', :to => 'despachar#recolectores', :as => "recolec"

  # url donde se muestra las ordenes recolectadas para ejecutar una simulacion de la entrega
  match ':locale/simulacion/', :to => 'despachar#simulacion', :as => "simul"

  match ':locale/guardarOrden/:id', :to => 'despachar#guardarOrden' , :as => "guardarOrden"

  match ':locale/recoleccionExterna', :to => 'despachar#recoleccionExterna' , :as => "recoExter"

  match ':locale/consultaExterna/:id', :to => 'despachar#consultaExterna' , :as => "consulExter"

  match ':locale/notificar', :to => 'ordens#notificar' , :as => "noti"
  
   match ':locale/nuevanotificacion/:id', :to => 'ordens#nuevanotificacion' , :as => "notis"

  # url donde se busca las ordenes para recolectarlas
  match ':locale/recolectar/', :to => 'recolectar#index', :as => "reco"

  #Informacion de la orden
  match ':locale/orden/:id', :to => 'recolectar#orden', :as => "recorden"

  # Genera el xml de los paquetes.
  match 'tracking/:id', :to => 'enviar#gen_xml', :via => 'get', :as => "genxml"

  #service
match ':locale/prueba/', :to => 'service#prueba', :as => "prueba"
  match 'getorden/:id', :to => 'service#getorden', :as => "getorden", :via => 'get'
  match 'setorden', :to => 'service#setorden', :as => "setorden", :via => 'post'

  # Pagina principal del proyecto.
  root :to => "courier#index"

  # Busca por get courier/contenido.
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
