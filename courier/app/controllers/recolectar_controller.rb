class RecolectarController < ApplicationController

  layout "enSistema"
  # GET /historicos
  # GET /historicos.xml
  def index
    @personas = Persona.find(session["id"])
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @ordens }
    end
  end

  # GET /historicos/1
  # GET /historicos/1.xml
  def show
    @personas = Persona.find(params["id"])
    @ordenes = Despachar.rutasAsignadas(@personas.id)
    if @ordenes.first.nil?
      render "sinOrden"
    end

  end

  # GET /historicos/new
  # GET /historicos/new.xml
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
    # @historico = Historico.new(params[:historico])

    # @var=params[:despachar]
    # if !(params[:enviar].nil?)
    #
    # @ordenes=params[:enviar]
    # @ordenes.each do |orden|
    # if orden[1] != "no"
    # @orden = Orden.find(orden[1])
    # @orden.empleado_id = @var["recolector"]
    # @orden.estado = "Asignada para Recoleccion"
    # @orden.save
    # end
    # end
    # end
    # @ordenprincipal = Orden.find(@var["orden"])
    # @ordenprincipal.estado = "Asignada para Recoleccion"
    # @ordenprincipal.empleado_id = @var["recolector"]
    # @ordenprincipal.save
    # redirect_to(despachador_path, :notice => 'La ruta de recoleccion fue asignada con exito.')

  end

  # Guarda y valida la informacion de la recoleccion
  def save
    @form = params['recolectar']
    @orden = Orden.where(:id => @form[:nombre]).first
    if @orden.nil? || @orden.estado == "Pendiente por recolectar" ||  @orden.estado == "Entregada"
      redirect_to(reco_path, :notice => 'La orden no existe, o no esta asgnada para recolectar')
    else
      @notice = Orden.rutaRecolectada(@orden)
      redirect_to(recorden_path(@orden.id), :notice => @notice)
    end
  end

  def ver
    @personas = Persona.find(params["id"])
    @ordenes = Despachar.rutasAsignadas(params["id"])
  end

  def orden
    @orden = Orden.find(params[:id])
    @paquetes = Paquete.where(:ordens_id => params[:id] )
    @historico = Orden.rutas(@orden.id)
  end

end
