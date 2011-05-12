class Companium < ActiveRecord::Base
  
  # Validaoms los formularios de la pagina compania, y relacionamos la tabla.
	validates :nombre	   , :presence => true
	validates :rif	   , :presence => true
	validates :direccionF, :presence => true
	validates :telefono  , :presence => true
	has_many :facturas
end
