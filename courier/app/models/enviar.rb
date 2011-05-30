class Enviar < ActiveRecord::Base
  validates :direccions  , :presence => true
  def self.montoTotal(id)
    @orden = Orden.find(id)
    @peso=0
    @contador=0
    @paquetes = Paquete.where(:ordens_id => id)
    @paquetes.each do |paquete|
      @peso=paquete.peso + @peso
      @contador = 1 + @contador
    end
    @direccion1= Direccion.find_by_sql("select * from historicos h, direccions d where d.id=h.direccions_id and h.tipo='Recolectada' and h.ordens_id=" + id.to_s).first
    @direccion2= Direccion.find_by_sql("select * from historicos h, direccions d where d.id=h.direccions_id and h.tipo='Entregada' and h.ordens_id=" + id.to_s).first
    @distancia=(Math.sqrt((@direccion1.lat-@direccion2.lat)**2 + (@direccion1.lng-@direccion2.lng)**2))*10
    @monto = ((60*@contador) + (( @peso + @distancia )* @contador) *10)+50
    return @monto
  end

end
