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
  # Muestra las rutas de la de la orden
  def self.rutas(id)
    return Historico.find_by_sql('Select h.fecha, h.tipo , d.ciudad, d.cPostal from historicos h, direccions d where h.direccions_id=d.id and h.fecha is not null and h.ordens_id=' + id.to_s + ' order by h.fecha DESC')
  end

  def self.rutaRecolectada(orden)
    if orden.estado != "Recolectada"
      orden.estado = "Recolectada"
      orden.empleado_id = nil
      @historico = Historico.where(:ordens_id => orden.id, :tipo => "Recolectada").first
      @historico.fecha = Time.now
      orden.save
      @historico.save
      return "La orden se ha recolectado con exito"
    else
      return "La orden ya fue recolectada en otro momento"
    end
  end
  
end
