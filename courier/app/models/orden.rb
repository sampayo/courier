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
  # Muestra las rutas de la de la orden buscandolas por un id en la tabla historico
  def self.rutas(id)
    return Historico.find_by_sql('Select h.fecha, h.tipo , d.* from historicos h, direccions d where h.direccions_id=d.id and h.fecha is not null and h.ordens_id=' + id.to_s + ' order by h.fecha DESC')
  end

  # Metodo que valida la ruta de recoleccion, se busca la ruta pasandole una orden
  # y se le cambia el estado a la orden a recolectada una vez que se haya ejecutado el metodo
  # e inmediatamente se guarda en el historico.
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

  # metodo valida todos los campos cliente, mediante el id del mismo pasado por parametros
  # de estar en la base de datos, revisa que el campo no este vacio.
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

  # metodo valida todos los campos direccion que ninguno que se este pasando por
  # el xml este vacio.
  def self.validarDireccion(direccion)
    if direccion[:nombre].nil? or direccion[:avCalle].nil? or direccion[:resCasa].nil? or direccion[:aptoNumero].nil? or direccion[:urban].nil? or direccion[:ciudad].nil? or direccion[:pais].nil? or direccion[:cPostal].nil? or direccion[:lat].nil? or direccion[:lng].nil?
    return false
    else
    return true
    end
  end

  # metodo valida todos los campos orden, recibidos en el xml, para que estos no sean vacios
  # dependiendo de los mismo retorna un booleano.
  def self.validarOrdenRemota(orden)
    if  orden[:nombre].nil? or orden[:apellido].nil? or orden[:fecha].nil?
    return false
    else
    return true
    end
  end

  # metodo valida todos los campos paquete, recibidos en el xml, para que estos no sean vacios
  # dependiendo de los mismo retorna un booleano.
  def self.validarPaquete(paquete)
    if paquete[:peso].nil? or paquete[:nombre].nil? or paquete[:descripcion].nil?  or paquete[:peso].to_i<=0
    return false
    else
    return true
    end
  end

  # metodo valida todos los campos tarjeta, recibidos en el xml, para que estos no sean vacios
  # dependiendo de los mismo retorna un booleano.
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
  
  # metodo valida todos los campos de la recoleccion, recibidos en el xml, para que estos no sean vacios
  # dependiendo de los mismo retorna un booleano. tambien busca que estos no sean vacios en la base de datos.
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

  # metodo valida todos los campos de la orden remota, recibidos en el xml, para que estos no sean vacios
  # dependiendo de los mismo retorna un booleano.
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

  # Metodo valida que las direcciones pasandole un id, y el nombre univoco, para la data traida del xml.
  def self.direcciones(id, nombre)
    return Direccion.find_by_sql("select * from historicos h, direccions d where d.id=h.direccions_id and h.tipo='" + nombre + "' and h.ordens_id=" + id.to_s).first
  end

end
