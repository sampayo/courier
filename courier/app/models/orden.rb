class Orden < ActiveRecord::Base
  
  # Validamos los formularios de la pagina Orden, y relacionamos la tabla.
	validates :nombre	 , :presence => true
	validates :apellido, :presence => true
	validates :estado	 , :presence => true
	belongs_to :personas
	has_one :facturas
	has_many :historicos
	has_many :paquetes
end
