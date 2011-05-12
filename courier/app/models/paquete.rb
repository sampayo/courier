class Paquete < ActiveRecord::Base
  
  # Validaoms los formularios de la pagina Paquete, y relacionamos la tabla.
	validates :nombre         , :presence => true
	validates :peso         , :presence => true
	validate :descripcion , :presence => true
	belongs_to :ordens
end
