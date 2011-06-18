class RecolectarController < ApplicationController

  layout "enSistema"
  # GET /historicos
  # GET /historicos.xml
  # Metodo para mostar el indes de recolectar
  def index
    @personas = Persona.find(session["id"])
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @ordens }
    end
  end

  # GET /historicos/1
  # GET /historicos/1.xml
  # Metodo para mostrar un recolectar
  def show
    @personas = Persona.find(params["id"])
    @ordenes = Despachar.rutasAsignadas(@personas.id)
    if @ordenes.first.nil?
      render "sinOrden"
    end

  end

  # GET /historicos/new
  # GET /historicos/new.xml
  # Metodo para crear una orden a recolectar 
  def new
    @historico = Historico.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @historico }
    end
  end

  # GET /historicos/1/edit
  # def edit
  # @historico = Historico.find(params[:id])
  # end

  # POST /historicos
  # POST /historicos.xml
  def create

  end

  # Guarda y valida la informacion de la recoleccion
  def save
    @form = params['recolectar']
    @orden = Orden.where(:id => @form[:nombre]).first
    if @orden.nil? || @orden.estado == "Pendiente por recolectar" ||  @orden.estado == "Entregada"
      redirect_to(reco_path, :notice => t('ordenrecolector'))
    else
      @notice = Orden.rutaRecolectada(@orden)
      redirect_to(recorden_path(@orden.id), :notice => @notice)
    end
  end
  
  # Muestra las rutas con el despachador
  def ver
    @personas = Persona.find(params["id"])
    @ordenes = Despachar.rutasAsignadas(params["id"])
  end

  # Metodo muestra las ordenes con paquete y la ruta
  def orden
    @orden = Orden.find(params[:id])
    @paquetes = Paquete.where(:ordens_id => params[:id] )
    @historico = Orden.rutas(@orden.id)
  end

end
