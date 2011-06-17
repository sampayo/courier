class Direccion < ActiveRecord::Base

  # Validaoms los formularios de la pagina direccion, y relacionamos la tabla.
  validates :avCalle, :presence => true
  validates :nombre, :presence => true
  validates :resCasa, :presence => true
  validates :aptoNumero, :presence => true
  validates_format_of :aptoNumero, :with => /\A[0-9]{1,16}\Z/, :on => :create
  validates_format_of :cPostal, :with => /\A[0-9]{1,16}\Z/, :on => :create
  validates :urban, :presence => true
  validates :ciudad, :presence => true
  validates :pais, :presence => true
  validates :cPostal, :presence => true
  validates :lat, :presence => true
  validates :lng, :presence => true
  belongs_to :personas

end
