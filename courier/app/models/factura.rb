class Factura < ActiveRecord::Base
  
  # Validaoms los formularios de la pagina Factura, y relacionamos la tabla.
  validates :costoTotal	 , :presence => true
  belongs_to :ordens
  belongs_to :tipo_pagos
  belongs_to :compania
  
  # Metodo que devuelve una el monto total de una factura pasandole el id
  # de dicha factura/orden 
  def self.facturatotal(id)
      return Factura.find_by_sql('SELECT f.id, o.id as numOrden, (f.costoTotal + f.iva) as monto, o.fecha from facturas f, ordens o where o.id=f.ordens_id and o.personas_id='+id.to_s)
  end
end
