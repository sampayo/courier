class Orden < ActiveRecord::Base
  
  # Validamos los formularios de la pagina Orden, y relacionamos la tabla.
	validates :nombre	 , :presence => true
	validates :apellido, :presence => true
	validates :estado	 , :presence => true
	belongs_to :personas
	has_one :facturas
	has_many :historicos
	has_many :paquetes
	belongs_to :personas
	
	
	def self.rutas(id)
    return Historico.find_by_sql('Select h.fecha, h.tipo , d.ciudad, d.cPostal from historicos h, direccions d where h.direccions_id=d.id and h.fecha is not null and h.ordens_id=' + id.to_s + ' order by h.fecha DESC')
  end
end
