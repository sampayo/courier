class Enviar < ActiveRecord::Base
  validates :direccions  , :presence => true
  validate :nombre , :presence => true
  validate :validate
    def validate()
      errors.add(:nombre, "debe ser positivo") if nombre.nil?   
    end
  #Metodo para calcular el costo de envio de la orden.
  def self.montoTotal(id)
    @orden = Orden.find(id)
    @peso=0
    @contador=0
    @paquetes = Paquete.where(:ordens_id => id)
    @paquetes.each do |paquete|
      @peso=paquete.peso + @peso
      @contador = 1 + @contador
    end
    @direccion1= Direccion.find_by_sql("select * from historicos h, direccions d where d.id=h.direccions_id and h.tipo='Recolectada' and h.ordens_id=" + id.to_s).first
    @direccion2= Direccion.find_by_sql("select * from historicos h, direccions d where d.id=h.direccions_id and h.tipo='Entregada' and h.ordens_id=" + id.to_s).first
    @distancia=(Math.sqrt((@direccion1.lat-@direccion2.lat)**2 + (@direccion1.lng-@direccion2.lng)**2))*10
    @monto = ((60*@contador) + (( @peso + @distancia )* @contador) *10)+50
    return @monto
  end

  #Valida que la fecha de la recoleccion y le coloca la fecha actual.
  def self.validarRecoleccion(id)
    @orden = Orden.find(id)
    @orden.estado = "Recolectada"
    @orden.empleado_id = nil
    @historico = Historico.where(:ordens_id => id , :tipo => 'Recolectada').first
    @historico.fecha = Time.now
    @historico.save
    @orden.save
  end
  
  def self.facturaxml(orden)
    return Factura.find_by_sql("select h.fecha, o.id, o.estado from historicos h , ordens o where o.id = h.ordens_id and h.tipo='Recolectada' AND o.id=" + orden.to_s).first
  end
  
    def self.compania
    @compania = Companium.where(:id => 1)
    if @compania.first.nil?
      @compania = Companium.new(:id =>1,:nombre => 'Courier Ucab', :rif => 'J-1234567890', :direccionF => 'Montalban', :telefono => '04142051140')
      @compania.save
    end
  end

end
