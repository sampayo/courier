class EnviarController < ApplicationController

  # Llamamos al layout enSistema que se encuentra en la carpeta layouts.
  layout "enSistema"

  # Incluimos el helper que se encuentra en helpers/enviar_helper.rb
  include EnviarHelper

  def montoTotal(id)
    @orden = Orden.find(id)
    @peso=0
    @contador=0
    @paquetes = Paquete.where(:ordens_id => id)
    @paquetes.each do |paquete|
      @peso=paquete.peso + @peso
      @contador = 1 + @contador
    end
    @direccion1= Direccion.find_by_sql("select * from historicos h, direccions d where d.id=h.direccions_id and h.tipo='inicio' and h.ordens_id=" + id.to_s).first
    @direccion2= Direccion.find_by_sql("select * from historicos h, direccions d where d.id=h.direccions_id and h.tipo='fin' and h.ordens_id=" + id.to_s).first
    @distancia=(Math.sqrt((@direccion1.lat-@direccion2.lat)**2 + (@direccion1.lng-@direccion2.lng)**2))*10
    @monto = ((60*@contador) + (( @peso + @distancia )* @contador) *10)+50
  end
  # POST /historicos
  # POST /historicos.xml
  # Metodo create
  def create
    @enviar = params[:enviar]
    @id = session[:id]
    @orden= Orden.new(:nombre => @enviar['nombre'], :apellido => @enviar['apellido'], :fecha => Time.now, :estado => "Pendiente por recolectar", :personas_id => @id)
    @orden.save
    @orden = Orden.where(:personas_id => @id).order("created_at DESC").first
    @paquetes = Paquete.where(:personas_id => @id, :ordens_id => nil )
    @paquetes.each do |paquete|
      @paquete = Paquete.find(paquete.id)
      @paquete.ordens_id = @orden.id
      @paquete.save
    end
    @historico1= Historico.new(:ordens_id => @orden.id, :direccions_id => @enviar['direccion1'], :tipo => 'inicio', :fecha=> Time.now)
    @historico= Historico.new(:ordens_id => @orden.id, :direccions_id => @enviar['direccion2'], :tipo => 'fin')
    @historico1.save
    @historico.save
    montoTotal(@orden.id)
    @iva = @monto * 0.12
    @factura = Factura.new(:companias_id => 1, :ordens_id =>@orden.id , :tipo_pagos_id => @enviar['tdc'], :costoTotal => @monto ,:iva => @iva)

    # redirect_to ordens_path
    respond_to do |format|
      if  @factura.save
        format.html { redirect_to(@factura, :notice => 'Tipo pago was successfully created.') }
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

  # def tipoPago
  # @orden=params[:id]
  # @tipo_pagos = TipoPago.where(:personas_id => session[:id])
  # respond_to do |format|
  # format.html # index.html.erb
  # format.xml  { render :xml => @tipo_pagos }
  # end
  # end

  # def factura
    # @enviar = params[:enviar]
    # montoTotal(@enviar['ordens_id'])
    # @iva = @monto * 0.12
    # @factura = Factura.new(:ordens_id => @enviar['ordens_id'], :companias_id => 1, :tipo_pagos_id => @enviar['tipo_pagos_id'], :costoTotal => @monto ,:iva => @iva)
    # @orden = Orden.find(@enviar['ordens_id'])
    # @orden.estado = "Pendiente por Recoleccion"
# 
    # respond_to do |format|
      # if @factura.save && @orden.save
        # format.html { redirect_to(@factura, :notice => 'Tipo pago was successfully created.') }
        # format.xml  { render :xml => @factura, :status => :created }
      # else
        # format.html { render :action => "new" }
        # format.xml  { render :xml => @factura.errors, :status => :unprocessable_entity }
      # end
    # end
  # end

  def gen_xml
    # @xml = Builder::XmlMarkup.new
    @id = params[:id]
    @orden = Orden.find(params[:id])
    unless @orden.estado == "Recolectada"
      @orden.estado = "Recolectada"
      @historico = Historico.where(:ordens_id => @id , :tipo => 'fin').first
    @historico.fecha = Time.now
    @historico.save
    @orden.save
    end
    @factura = Factura.find_by_sql("select h.fecha, o.id, o.estado from historicos h , ordens o where o.id = h.ordens_id and h.tipo='fin' AND o.id=" + @id).first
    render :layout => false
  end

end

