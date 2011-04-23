class Direccion < ActiveRecord::Base
	validates :avCalle, :presence => true
	validates :resCasa, :presence => true
	validates :aptoNumero, :presence => true
	validates :urban, :presence => true
	validates :ciudad, :presence => true
	validates :pais, :presence => true
	validates :cPostal, :presence => true
	validates :lat, :presence => true
	validates :lng, :presence => true
	belongs_to :personas

end
