class Paquete < ActiveRecord::Base

  # Validaoms los formularios de la pagina Paquete, y relacionamos la tabla.
  validates :nombre         , :presence => true
  validates :peso         , :presence => true
  validates_numericality_of :peso
  validates :descripcion , :presence => true
  belongs_to :ordens
  belongs_to :personas
  validate :validate
  
  # Metodo el cual valida que el peso del paquete no sea menor o igual a cero,
  # enviando un error de este llegar a ser negativo.
  def validate()
    errors.add(:peso, "debe ser positivo") if peso < 0
  end
end
