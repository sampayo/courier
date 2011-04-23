class Companium < ActiveRecord::Base
	validates :nombre	   , :presence => true
	validates :rif	   , :presence => true
	validates :direccionF, :presence => true
	validates :telefono  , :presence => true
	has_many :facturas
end
