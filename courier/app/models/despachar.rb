class Despachar < ActiveRecord::Base
  # retorna las ordenes crecanadas con una lat y longitud 
  def self.ordenesCercanas(id,lat,lng)
    return Orden.find_by_sql('Select o.*, d.lat, d.lng,SQRT(POWER(d.lat- (' + lat.to_s + '), 2)+POWER(d.lng-(' + lng.to_s + '), 2)) as distancia from ordens o, direccions d, historicos h where o.estado="Pendiente por recolectar" and h.direccions_id=d.id and h.ordens_id=o.id and h.tipo="Recolectada"  and o.id <>' + id.to_s)
  end

  # retorna la direccion de una orden en especifico pasandole un id de la orden.
  def self.orden(id)
    return Orden.find_by_sql('Select o.id, d.lat, d.lng from ordens o, direccions d, historicos h where o.estado="Pendiente por recolectar" and h.direccions_id=d.id and h.ordens_id=o.id and h.tipo="Recolectada" and o.id =' + id.to_s).first
  end

  # retorna el recolector que este desocupado
  def self.recolectorDesocupado
    return Orden.find_by_sql('select DISTINCT * from personas p where p.empleados_id=2 and p.id not in (select o.empleado_id from ordens o where o.empleado_id is not null)')
  end

  # muestra la ruta que tenga asignadas un recolector pasandole el id del recolector.
  def self.rutasAsignadas(id)
    return Orden.find_by_sql('Select o.*, d.ciudad, d.pais, d.avCalle, d.urban, d.resCasa,d.aptoNumero, d.lat, d.lng from ordens o, direccions d, historicos h where o.estado="Asignada para Recoleccion" and h.direccions_id=d.id and h.ordens_id=o.id and h.tipo="Recolectada" and o.empleado_id='+ id.to_s)
  end
 # Metodo que simula una orden agregandole directamente 2 o 3 sitios por donde pasa dicha orden
 # pasandole el id de la orden la cual queremos simular.
  def self.simular(id)
    @direcciones = Direccion.find_by_sql('select * from direccions d where d.id not in (select h.direccions_id from ordens o, historicos h where h.ordens_id=o.id and o.id=' + id.to_s + ') limit 3')
    if @direcciones.first.nil?
      @direccion = Direccion.new(:nombre => 'paso', :avCalle => 'Los bucares', :resCasa => 'Las trinitarias', :aptoNumero => 3, :urban => 'Alto Pradp', :ciudad => 'Caracas', :pais => 'Venezuela', :cPostal =>1313, :lat => 10.4392, :lng => -66.6559)
      @direccion2 = Direccion.new(:nombre => 'paso2', :avCalle => 'Los campitos', :resCasa => 'Pareque Real', :aptoNumero => 3, :urban => 'Santa Fe', :ciudad => 'Caracas', :pais => 'Venezuela', :cPostal =>1311, :lat => 10.4292, :lng => -66.6259)
      @direccion2.save
      @direccion.save
      return  Direccion.find_by_sql('select * from direccions d where d.id not in (select h.direccions_id from ordens o, historicos h where h.ordens_id=o.id and o.id=' + id.to_s + ') limit 3')
    else
      return  Direccion.find_by_sql('select * from direccions d where d.id not in (select h.direccions_id from ordens o, historicos h where h.ordens_id=o.id and o.id=' + id.to_s + ') limit 3')
    end
  end

end