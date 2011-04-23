class Persona < ActiveRecord::Base
	validates :nombre,  :presence => true
	validates :email,  :presence => true
	validates :apellido,  :presence => true
	validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, :on => :create
	has_many :tipo_pagos
	has_many :ordens
	has_many :direccions
	has_one :empleados
	
end
