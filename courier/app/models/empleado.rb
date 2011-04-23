class Empleado < ActiveRecord::Base
	validates :cargo	 , :presence => true
	belongs_to :personas
	
end
