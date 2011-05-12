class Factura < ActiveRecord::Base
  
  # Validaoms los formularios de la pagina Factura, y relacionamos la tabla.
  validates :costoTotal	 , :presence => true
  belongs_to :ordens
  belongs_to :tipo_pagos
  belongs_to :compania
end
