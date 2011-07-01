class Courierucab
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
    @xml = '<solicitud><cliente><email>ricardo9588@gmail.com</email></cliente>
  <orden>
    <nombre>' + @orden.nombre + '</nombre>
    <apellido>' + @orden.apellido + '</apellido>
    <fecha>' + @orden.fecha.to_s + '</fecha>
  </orden>
  <direccionrecoleccion>
    <nombre>Ofic</nombre>
  </direccionrecoleccion>
  <direccionentrega>
    <nombre>' + @direccion2.nombre + '</nombre>
    <avCalle>' + @direccion2.avCalle + '</avCalle>
    <resCasa>' + @direccion2.resCasa + '</resCasa>
    <aptoNumero>' + @direccion2.aptoNumero.to_s + '</aptoNumero>
    <urban>' + @direccion2.urban + '</urban>
    <ciudad>' + @direccion2.ciudad + '</ciudad>
    <pais>' + @direccion2.pais + '</pais>
    <cPostal>' + @direccion2.cPostal + '</cPostal>
    <lat>' + @direccion2.lat.to_s + '</lat>
    <lng>' + @direccion2.lng.to_s + '</lng>
  </direccionentrega>
  <tarjeta>
    <nTDC>123456789012345</nTDC>
  </tarjeta>
  <paquete>
    <nombre>' + @paquete.nombre + '</nombre>
    <peso>' + @paquete.peso.to_s + '</peso>
    <descripcion>' + @paquete.descripcion + '</descripcion>
  </paquete>
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
      if xmlresponse["Error"]
        return xmlresponse["Error"]["error"]
      else
        @orden.remoto = xmlresponse["Tracking"]["info"]["tracking"]
        @monto = xmlresponse["Tracking"]["info"]["montoTotal"]
        @orden.estado = 'Recoleccion Externa'
        @factura.companias_id = @empresa.id
        if @factura.costoTotal < @monto.to_i
          @factura.costoTotal = @monto.to_i
          @orden.notificacion = 'alerta'
        end
        @factura.save
        @orden.save
        return 'La orden a pasado a estatus Recoleccion Externa'
      end
    when Net::HTTPSuccess
      if xmlresponse["Error"]
        return xmlresponse["Error"]["error"]
      else
        @orden.remoto = xmlresponse["Tracking"]["info"]["tracking"]
        @monto = xmlresponse["Tracking"]["info"]["montoTotal"]
        @orden.estado = 'Recoleccion Externa'
        @factura.companias_id = @empresa.id
        if @factura.costoTotal < @monto.to_i
          @factura.costoTotal = @monto.to_i
          @orden.notificacion = 'alerta'
        end
        @factura.save
        @orden.save
        return 'La orden a pasado a estatus Recoleccion Externa'
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
      if !(xmlresponse["Tracking"]["movimiento"].nil?)
        xmlresponse["Tracking"]["movimiento"].each do |admin|
          
          if admin['fecha'].nil?
            fecha = Time.now
          else
            fecha = admin['fecha']
          end
          
          if admin['desc']!='Entregada'
            @direccion = Direccion.new(:nombre => admin['nombre'], :avCalle => admin['calle'], :resCasa => admin['casa'], :aptoNumero => admin['numero'], :urban => ['urbanizacion'], :ciudad => admin['ciudad'], :pais => admin['pais'], :cPostal => admin['codigopostal'], :lat => admin ['lat'], :lng => admin['lng'])
            @direccion.save
            @historico = Historico.new(:tipo => admin['desc'], :fecha => fecha, :ordens_id=>@orden.id, :direccions_id => @direccion.id)
          @historico.save
          else
            @historico = Historico.where(:tipo => 'Entregada', :ordens_id => @orden.id).first
          @historico.fecha = fecha
          @historico.save
          end

        end
        @orden.estado = 'Entregada'
      @orden.save
      end
    else response.error!
    return 'Error'
    end
  end

end

