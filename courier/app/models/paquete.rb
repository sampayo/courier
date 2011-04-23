class Paquete < ActiveRecord::Base
	validates :nombre         , :presence => true
	validates :peso         , :presence => true
	validate :descripcion , :presence => true
	belongs_to :ordens
end
