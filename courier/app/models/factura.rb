class Factura < ActiveRecord::Base
	      validates :costoTotal	 , :presence => true
	      belongs_to :ordens
	      belongs_to :tipo_pagos
	      belongs_to :compania
end
