class ErrorsController < ApplicationController
  
  # Metodo de revision de rutas, revisa el routes.rb de no existir la pagina que estamos buscando mostramos pagina de error.
  def routing
    render :file => "#{Rails.root}/public/404", :status => 404, :layout => true
  end
end