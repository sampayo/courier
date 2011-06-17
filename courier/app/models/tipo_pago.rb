class TipoPago < ActiveRecord::Base
  
  # Validamos los formularios de la pagina TipoPago, y relacionamos la tabla.
	belongs_to :personas
	validates :nombre		 , :presence => true
	validates :nTDC		 , :presence => true
	validates :cSeguridad	 , :presence => true
	validates :fVencimiento, :presence => true
	 validates_format_of :nTDC, :with => /\A[0-9]{10,16}\Z/, :on => :create
	validates_length_of :nTDC, :minimum => 6
	belongs_to :personas
	has_many :facturas
	
	
	validate :validarTdc 
  
  # Metodo para verifar las fechas de la tarjetas. 
  def validarTdc
    errors.add(:fVencimiento, "La fecha esta vencida") if
      !fVencimiento.blank? and fVencimiento < Date.today
  end
 

end


