class Empleado < ActiveRecord::Base
  
  # Validaoms los formularios de la pagina emplado, y relacionamos la tabla.
	validates :cargo	 , :presence => true
	belongs_to :personas
	
end
