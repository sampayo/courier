class Orden < ActiveRecord::Base

  # Validamos los formularios de la pagina Orden, y relacionamos la tabla.
  validates :nombre	 , :presence => true
  validates :apellido, :presence => true
  validates :estado	 , :presence => true
  belongs_to :personas
  has_one :facturas
  has_many :historicos
  has_many :paquetes
  belongs_to :personas
  # Muestra las rutas de la de la orden
  def self.rutas(id)
    return Historico.find_by_sql('Select h.fecha, h.tipo , d.* from historicos h, direccions d where h.direccions_id=d.id and h.fecha is not null and h.ordens_id=' + id.to_s + ' order by h.fecha DESC')
  end

  # Metodo que valida la ruta de recoleccion
  def self.rutaRecolectada(orden)
    if orden.estado != "Recolectada"
      orden.estado = "Recolectada"
      orden.empleado_id = nil
      @historico = Historico.where(:ordens_id => orden.id, :tipo => "Recolectada").first
      @historico.fecha = Time.now
      orden.save
      @historico.save
      return "La orden se ha recolectado con exito"
    else
      return "La orden ya fue recolectada en otro momento"
    end
  end

  # metodo valida todos los campos cliente
  def self.validarCliente(cliente)
    if cliente[:email].nil?
      return nil
    else
      @cliente = Persona.where(:email => cliente[:email]).first
      if @cliente.nil?
        return nil
      else
      return @cliente.id
      end
    end
  end

  # metodo valida todos los campos direccion
  def self.validarDireccion(direccion)
    if direccion[:nombre].nil? or direccion[:avCalle].nil? or direccion[:resCasa].nil? or direccion[:aptoNumero].nil? or direccion[:urban].nil? or direccion[:ciudad].nil? or direccion[:pais].nil? or direccion[:cPostal].nil? or direccion[:lat].nil? or direccion[:lng].nil?
    return false
    else
    return true
    end
  end

  # metodo valida todos los campos orden
  def self.validarOrdenRemota(orden)
    if  orden[:nombre].nil? or orden[:apellido].nil? or orden[:fecha].nil?
    return false
    else
    return true
    end
  end

  # metodo valida todos los campos paquete
  def self.validarPaquete(paquete)
    if paquete[:peso].nil? or paquete[:nombre].nil? or paquete[:descripcion].nil?  or paquete[:peso].to_i<=0
    return false
    else
    return true
    end
  end

  # metodo valida todos los campos tarjeta
  def self.validartarjeta(tarjeta)
    if tarjeta[:nTDC].nil?
      return nil
    else
      @cliente = TipoPago.where(:nTDC => tarjeta[:nTDC]).first
      if @cliente.nil?
        return nil
      else
      return @cliente.id
      end
    end
  end

  def self.validarrecoleccion(direccion)
    if direccion[:nombre].nil?
      return nil
    else
      @cliente = Direccion.where(:nombre => direccion[:nombre]).first
      if @cliente.nil?
        return nil
      else
      return @cliente.id
      end
    end
  end

  # metodo valida todos los campos de la orden remota
  def self.validarRemota(xml)
    @cli = validarCliente(xml[:cliente])
    @tar = validartarjeta(xml[:tarjeta])
    @dir = validarrecoleccion(xml[:direccionrecoleccion])
    if !(@cli.nil?) and validarOrdenRemota(xml[:orden]) and validarPaquete(xml[:paquete]) and validarDireccion(xml[:direccionentrega]) and !(@dir.nil?) and !(@tar.nil?)
      return [@cli,@tar,@dir]
    else
      return nil
    end
  end

  def self.direcciones(id, nombre)
    return Direccion.find_by_sql("select * from historicos h, direccions d where d.id=h.direccions_id and h.tipo='" + nombre + "' and h.ordens_id=" + id.to_s).first
  end

end
