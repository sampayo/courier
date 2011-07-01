class Giancourier
  attr_accessor :orden, :empresa
  require 'open-uri'
  require 'net/http'

  def initialize(id,id2)
    @orden = Orden.find(id)
    @empresa = Companium.find(id2)
  end

  def xml
    @persona = Persona.find(@orden.personas_id)
    # @tdc = TipoPago.find(@orden.)
    @direccion1 = Orden.direcciones(@orden.id,'Recolectada')
    @direccion2 = Orden.direcciones(@orden.id,'Entregada')
    @paquete = Paquete.where(:ordens_id => @orden.id).first
    @factura = Factura.where(:ordens_id => @orden.id).first
    @tdc = TipoPago.find(@factura.tipo_pagos_id)
    @xml = '<solicitud><cliente><tarjeta>123456789012345</tarjeta><nombre_direccion>Ofic</nombre_direccion>
    <correo>ricardo9588@gmail.com</correo></cliente>
    <orden>
<nombre_receptor>' + @orden.nombre + '</nombre_receptor>
<apellido_receptor>' + @orden.apellido + '</apellido_receptor>
  <residencia_calle>' + @direccion2.avCalle + '</residencia_calle>
  <apartamento_num_casa>' + @direccion2.aptoNumero.to_s + '</apartamento_num_casa>
  <urbanizacion>' + @direccion2.urban + '</urbanizacion>
  <ciudad>' + @direccion2.ciudad + '</ciudad>
  <pais>' + @direccion2.pais + '</pais>
</orden>
<paquetes>
<paquete>
  <peso>' + @paquete.peso.to_s + '</peso>
  <descripcion>' + @paquete.descripcion + '</descripcion>
</paquete>
</paquetes>
</solicitud>'

  end

  def enviarpost
    xml
    uri = URI.parse(@empresa.urlset)
    http = Net::HTTP.new(uri.host, uri.port)
    headers = { 'Content-Type'=>'application/xml', 'Content-Length'=>@xml.size.to_s }
    post = Net::HTTP::Post.new(uri.path, headers)
    response = http.request post, @xml
    xmlresponse = Hash.from_xml(response.body)
    case response
    when Net::HTTPCreated
      if xmlresponse["respuesta"]
        @orden.remoto = xmlresponse["respuesta"]["traking"]
        @monto = xmlresponse["respuesta"]["costo"]
        if @factura.costoTotal < @monto.to_i
          @factura.costoTotal = @monto.to_i
          @orden.notificacion = 'alerta'
        end
        @factura.save
        @orden.save
        return 'La orden a pasado a estatus Recoleccion Externa'
      else
        return 'error de coneccion'
      end
    when Net::HTTPSuccess
      if xmlresponse["respuesta"]
        @orden.remoto = xmlresponse["respuesta"]["traking"]
        @monto = xmlresponse["respuesta"]["costo"]
        if @factura.costoTotal < @monto.to_i
          @factura.costoTotal = @monto.to_i
          @orden.notificacion = 'alerta'
        end
        @factura.save
        @orden.save
        return 'La orden a pasado a estatus Recoleccion Externa'
      else
        return 'error de coneccion'
      end
    else response.error!
    return 'Error'
    end

  end

  def leerXml
    uri = URI.parse(@empresa.urlget + '/' + @orden.remoto.to_s)
    http = Net::HTTP.new(uri.host, uri.port)
    headers = { 'Content-Type'=>'application/xml' }
    post = Net::HTTP::Get.new(uri.path, headers)
    response = http.request post

    xmlresponse = Hash.from_xml(response.body)
    case response
    when Net::HTTPCreated
      return xmlresponse["Tracking"]["orden"]["Orden"]
    when Net::HTTPSuccess

      if !(xmlresponse["seguimiento"]["etapas"]["etapa"].nil?)
        xmlresponse["seguimiento"]["etapas"]["etapa"].each do |admin|
          if admin['fecha'].nil?
            fecha = Time.now
          else
            fecha = admin['fecha']
          end

          @direccion = Direccion.new(:nombre => '', :avCalle => '', :resCasa => '', :aptoNumero => 2, :urban => admin['lugar'], :ciudad => 'Caracas', :pais => 'Venezuela', :cPostal => 122, :lat => nil, :lng => nil)
          @direccion.save
          @historico = Historico.new(:tipo => admin['descripcion'], :fecha => fecha, :ordens_id=>@orden.id, :direccions_id => @direccion.id)
          @historico.save
        end
        @historico = Historico.find( @direccion2.idHistorico)
        @historico.fecha = Time.now
        @historico.save
        @orden.estado = 'Entregada'
      @orden.save
      end
    else response.error!
    return 'Error'
    end
  end
end

