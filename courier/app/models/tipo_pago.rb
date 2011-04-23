class TipoPago < ActiveRecord::Base
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
 
  def validarTdc
    errors.add(:fVencimiento, "La fecha esta vencida") if
      !fVencimiento.blank? and fVencimiento < Date.today
  end
 

end


