class Historico < ActiveRecord::Base
  
  # Validamos los formularios de la pagina historico, y relacionamos la tabla.
  validates :tipo	 , :presence => true
  belongs_to :ordens
  belongs_to :direccions
end
