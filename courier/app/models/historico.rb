class Historico < ActiveRecord::Base

  # Validamos los formularios de la pagina historico, y relacionamos la tabla.
  validates :tipo	 , :presence => true
  belongs_to :ordens
  belongs_to :direccions
  
  # Metodo que devuelve el seguimiento del paquete que se encuentra en la tabla
  # Historico buscando toda la informacion en la tabla.
  def self.seguimiento1(busqueda)
    return Historico.find_by_sql('Select h.fecha, h.tipo , d.ciudad, d.cPostal from historicos h, direccions d where h.direccions_id=d.id and h.fecha is not null and h.ordens_id=' + busqueda.to_s + ' order by h.fecha DESC')
  end

end
