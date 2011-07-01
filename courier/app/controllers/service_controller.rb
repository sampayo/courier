class ServiceController < ApplicationController
  skip_before_filter :verify_authenticity_token
  #http://www.google.com/translate?twu=1&u=http://www.ultrasaurus.com/sarahblog/2009/06/simple-web-services-with-rails/
  #http://www.ultrasaurus.com/sarahblog/2009/06/simple-web-services-with-rails/

  # Utilizamos open-uri para leer los xml
  require 'open-uri'
  require 'net/http'

  def show
    @factura = Factura.find(1)
    @algo = Courierucab.new(1)
    # @algo.orden ="aaa"
    # @algo = @algo.orden.nombre
    # @algo.xml
    # @algo = @algo.enviarpost
    @algo = @algo.leerXml
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @historico }
    end
  end

  def prueba #solicita GET

    data = open('http://192.168.0.188:3000/xml/1').read
    # @a = xml_result_set.body
    @a = data
  end

  # Recibe un id y retorna la informacion de la orden
  def getorden
    @id = params['id']
    @orden = Orden.find(@id)
    @factura = Factura.where(:ordens_id =>  @id).first
    @monto= @factura.iva + @factura.costoTotal

    @historico = Orden.rutas(@id)

    respond_to do |format|
    # format.html # show.html.erb
      format.xml
    end
  end

  # Recibe toda la informacion en un /post para crear una orden por webservice
  def setorden
    @xml = params[:solicitud]
    @arreglo = Orden.validarRemota(@xml)
    if !(@arreglo.nil?)
      # @cliente = Persona.new(@xml[:cliente])
      # @cliente.save

      # @tarjeta = @xml[:tarjeta]
      # @tarjeta = TipoPago.new(@tarjeta)
      # @tarjeta.personas_id = @cliente.id
      # @tarjeta.save

      # @recoleccion = Direccion.new(@xml[:direccionrecoleccion])
      @entrega = Direccion.new(@xml[:direccionentrega])
      # @recoleccion.save
      @entrega.save

      @orden = Orden.new(@xml[:orden])
      @orden.estado = 'Pendiente por recolectar'
      @orden.personas_id= @arreglo[0]
      @orden.save

      @paquete = Paquete.new(@xml[:paquete])
      @paquete.ordens_id = @orden.id
      @paquete.personas_id = @arreglo[0]
      @paquete.save

      @historico1= Historico.new(:ordens_id => @orden.id, :direccions_id => @arreglo[2], :tipo => 'Recolectada')
      @historico= Historico.new(:ordens_id => @orden.id, :direccions_id => @entrega.id, :tipo => 'Entregada')
      @historico1.save
      @historico.save
      
      @monto = Enviar.montoTotal(@orden.id)
      @iva = (@monto * 0.12).round(2)
      @montototal = @monto + @iva
      Enviar.compania
      @factura = Factura.new(:companias_id => 1, :ordens_id =>@orden.id , :tipo_pagos_id => @arreglo[1] , :costoTotal => @monto ,:iva => @iva)
      @factura.save
    else
      render "errorxml"
    end
  end
end

