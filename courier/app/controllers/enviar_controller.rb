class EnviarController < ApplicationController
  layout "enSistema"
  include EnviarHelper
  # POST /historicos
  # POST /historicos.xml
  def create
    @enviar = params[:enviar]
    @historico1= Historico.new(:ordens_id => @enviar['ordens_id'], :direccions_id => @enviar['direccions_id'], :tipo => 'inicio', :fecha=> Time.now)
    @historico= Historico.new(:ordens_id => @enviar['ordens_id'], :direccions_id => @enviar['direccions'], :tipo => 'fin')

    # redirect_to ordens_path
    respond_to do |format|
      if @historico1.save && @historico.save
        format.html { redirect_to(tipoPago_path(@enviar['ordens_id']), :notice => 'Historico was successfully created.') }
        format.xml  { render :xml => @historico, :status => :created, :location => @historico }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @historico.errors, :status => :unprocessable_entity }
      end
    end
  end

  def show
    @direccions = Direccion.where(:personas_id => session[:id])
    @enviar = Historico.new
    @orden=params[:id]

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @historico }
    end
  end

  def tipoPago
    @orden=params[:id]
    @tipo_pagos = TipoPago.where(:personas_id => session[:id])
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @tipo_pagos }
    end
  end

  def montoTotal(id)
    @orden = Orden.find(id)
    @peso=0
    @contador=0
    @paquetes = Paquete.where(:ordens_id => id)
    @paquetes.each do |paquete|
      @peso=paquete.peso + @peso
      @contador = 1 + @contador
    end
    @direccion1= Direccion.find_by_sql("select * from historicos h, direccions d where d.id=h.direccions_id and h.tipo='inicio' and h.ordens_id=" + id).first
    @direccion2= Direccion.find_by_sql("select * from historicos h, direccions d where d.id=h.direccions_id and h.tipo='fin' and h.ordens_id=" + id).first
    @distancia=(Math.sqrt((@direccion1.lat-@direccion2.lat)**2 + (@direccion1.lng-@direccion2.lng)**2))*10
    @monto = ((60*@contador) + (( @peso + @distancia )* @contador) *10)+50
    @lala=@monto
  end

  def factura
    @enviar = params[:enviar]
    montoTotal(@enviar['ordens_id'])
    @iva = @monto * 0.12
    @factura = Factura.new(:ordens_id => @enviar['ordens_id'], :companias_id => 1, :tipo_pagos_id => @enviar['tipo_pagos_id'], :costoTotal => @monto ,:iva => @iva)
    @orden = Orden.find(@enviar['ordens_id'])
    @orden.estado = "Pendiente por Recoleccion"

    respond_to do |format|
      if @factura.save && @orden.save
        format.html { redirect_to(@factura, :notice => 'Tipo pago was successfully created.') }
        format.xml  { render :xml => @factura, :status => :created }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @factura.errors, :status => :unprocessable_entity }
      end
    end
  end

  def gen_xml
    # @xml = Builder::XmlMarkup.new
    @id = params[:id]
    @orden = Orden.find(params[:id])
    @orden.estado = "Recolectada"
    @historico = Historico.where(:ordens_id => @id , :tipo => 'fin').first
    @historico.fecha = Time.now
    @historico.save
    @orden.save 
    @addresses = Factura.find_by_sql("select h.fecha, o.id, o.estado from historicos h , ordens o where o.id = h.ordens_id and h.tipo='fin' AND o.id=" + @id).first
    #@addresses = Factura.find(1)
    render :layout => false
  end

end

