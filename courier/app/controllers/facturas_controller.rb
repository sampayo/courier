require 'rubygems'
require 'prawn'
require 'prawn/security'
require "prawn/layout"
class FacturasController < ApplicationController
  
  #Llamamos al layout enSistema que se encuentra en la carpeta layouts.
  layout "enSistema"
  # GET /facturas
  # GET /facturas.xml
  
  # Metodo utilizado en la pagina index, y realizamos una busqueda en base de datos una factura.
  def index
    @facturas = Factura.facturatotal(session[:id])

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @facturas }
    end
  end

  # llamada a motrar una factura, pasandole un parametro, y nos traemos la Orden, Paquete del cliente.
  # GET /facturas/1
  # GET /facturas/1.xml
  def show
    #Llamada al metodo ip que se encuetra dentro de application_controller.rb y lo asignamos a la variable.
    @remote_ip = ip
    @factura = Factura.find(params[:id])
    @orden = Orden.where(:id => @factura.ordens_id).first
    @paquete = Paquete.where(:ordens_id => @factura.ordens_id)
    @compania = Companium.find(@factura.companias_id)
    @cliente = Persona.find(@orden.personas_id)
    @total = @factura.costoTotal + @factura.iva
    @dirQR = "https://chart.googleapis.com/chart?cht=qr&chs=250x250&chl=http://" + @remote_ip.to_s + ":3000/tracking/" + @orden.id.to_s
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @factura }
      format.pdf { render :format=>false, :attachment=>false}
      #format.pdf {render :pdf => "filename", :stylesheets => "factura"} 
    end
  end
  
  # llamada a la pagina new de factura.
  # GET /facturas/new
  # GET /facturas/new.xml
  def new
    @factura = Factura.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @factura }
    end
  end

  # llamada a la pagina new de factura, pasandole un parametro.
  # GET /facturas/1/edit
  def edit
    @factura = Factura.find(params[:id])
  end

  # Creamos una factura, cuando llenamos el formulario de la pagina.
  # POST /facturas
  # POST /facturas.xml
  def create
    @factura = Factura.new(params[:factura])
    respond_to do |format|
      if @factura.save
        format.html { redirect_to(@factura, :notice => t('facturacreada')) }
        format.xml  { render :xml => @factura, :status => :created, :location => @factura }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @factura.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  #Buscamos una factura pasandole un parametro.
  # PUT /facturas/1
  # PUT /facturas/1.xml
  def update
    @factura = Factura.find(params[:id])

    respond_to do |format|
      if @factura.update_attributes(params[:factura])
        format.html { redirect_to(@factura, :notice => t('facturaactualizada')) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @factura.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  # Destruimos una factura, pasandole un parametro.
  # DELETE /facturas/1
  # DELETE /facturas/1.xml
  def destroy
    @factura = Factura.find(params[:id])
    @factura.destroy

    respond_to do |format|
      format.html { redirect_to(facturas_url) }
      format.xml  { head :ok }
    end
  end
end
