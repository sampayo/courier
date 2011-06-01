class Despachar < ActiveRecord::Base
  # retorna las ordenes crecanad a una lat y longitud
  def self.ordenesCercanas(id,lat,lng)
    return Orden.find_by_sql('Select o.*, d.lat, d.lng,SQRT(POWER(d.lat- (' + lat.to_s + '), 2)+POWER(d.lng-(' + lng.to_s + '), 2)) as distancia from ordens o, direccions d, historicos h where o.estado="Pendiente por recolectar" and h.direccions_id=d.id and h.ordens_id=o.id and h.tipo="Recolectada"  and o.id <>' + id.to_s)
  end
   # retorna la direccion de una orden en especifico
  def self.orden(id)
    return Orden.find_by_sql('Select o.id, d.lat, d.lng from ordens o, direccions d, historicos h where o.estado="Pendiente por recolectar" and h.direccions_id=d.id and h.ordens_id=o.id and h.tipo="Recolectada" and o.id =' + id.to_s).first
  end
  
  def self.recolectorDesocupado
    return Orden.find_by_sql('select DISTINCT * from personas p where p.empleados_id=2 and p.id not in (select o.empleado_id from ordens o where o.empleado_id is not null)')
  end
end