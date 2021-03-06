class EnviarController < ApplicationController

  # Llamamos al layout enSistema que se encuentra en la carpeta layouts.
  layout "enSistema"

  # Incluimos el helper que se encuentra en helpers/enviar_helper.rb
  include EnviarHelper


  # POST /historicos
  # POST /historicos.xml
  # Metodo create para despachar una orden
  def create
    @enviar = params[:enviar]
    @id = session[:id]
    @orden= Orden.new(:nombre => @enviar['nombre'], :apellido => @enviar['apellido'], :fecha => Time.now, :estado => "Pendiente por recolectar", :personas_id => @id)
    @orden.save
    NUESTRO_LOG.info "Se guardo la orden correctamente"
    @orden = Orden.where(:personas_id => @id).order("created_at DESC").first
    @paquetes = Paquete.where(:personas_id => @id, :ordens_id => nil )
    @paquetes.each do |paquete|
      @paquete = Paquete.find(paquete.id)
      @paquete.ordens_id = @orden.id
      @paquete.save
      NUESTRO_LOG.info "Se guardo el paquete correctamente"
    end
    @historico1= Historico.new(:ordens_id => @orden.id, :direccions_id => @enviar['direccion1'], :tipo => 'Recolectada')
    @historico= Historico.new(:ordens_id => @orden.id, :direccions_id => @enviar['direccion2'], :tipo => 'Entregada')
    @historico1.save
    @historico.save
    NUESTRO_LOG.info "Se guardo el historico correctamente"
    @monto = Enviar.montoTotal(@orden.id)
    @iva = @monto * 0.12
    Enviar.compania
    @factura = Factura.new(:companias_id => 1, :ordens_id =>@orden.id , :tipo_pagos_id => @enviar['tdc'], :costoTotal => @monto ,:iva => @iva)

    # redirect_to ordens_path
    respond_to do |format|
      if  @factura.save
        NUESTRO_LOG.info "Se guardo el tipopago correctamente"
        format.html { redirect_to(@factura, :notice => t('tipopagocreado')) }
        format.xml  { render :xml => @historico, :status => :created, :location => @historico }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @historico.errors, :status => :unprocessable_entity }
      end
    end
  end

  # llamada a motrar una direccion, pasandole un parametro.
  def show
    @tdc = TipoPago.where(:personas_id => session[:id])
    @direccions = Direccion.where(:personas_id => session[:id])
    @orden=params[:id]

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @historico }
    end
  end

  # Metodo genera el xml de la orden
  def gen_xml
    # @xml = Builder::XmlMarkup.new
    @id = params[:id]
    @orden = Orden.find(params[:id])
    unless @orden.estado == "Recolectada" ||  @orden.estado == "Entregada"
      Enviar.validarRecoleccion(@orden.id)
    end
    @factura = Enviar.facturaxml(@id)
    render :layout => false
  end

end

