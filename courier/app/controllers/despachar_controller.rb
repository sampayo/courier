class DespacharController < ApplicationController
  layout "enSistema"
  # GET /historicos
  # GET /historicos.xml
  # Metodo para mostar el index de despachar
  def index
    @ordens = Orden.where(:estado => "Pendiente por Recolectar").order("created_at DESC")
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @ordens }
    end
  end

  # GET /historicos/1
  # GET /historicos/1.xml
  # Metodo para mostrar la orden a despachar
  def show
    @orden = Despachar.orden(params[:id])
    @recolector = Despachar.recolectorDesocupado
    @direccionCercana= Despachar.ordenesCercanas(params[:id],@orden.lat,@orden.lng)
    @count=0
    if @recolector.first.nil?
      render "sinRecolector"
    end

  end

  # GET /historicos/new
  # GET /historicos/new.xml
  # Metodo para crear una orden a despachar
  def new
    @historico = Historico.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @historico }
    end
  end

  # POST /historicos
  # POST /historicos.xml
  # Metodo para crear un paquete a despachar
  def create

    @var=params[:despachar]
    if !(params[:enviar].nil?)

      @ordenes=params[:enviar]
      @ordenes.each do |orden|
        if orden[1] != "no"
          @orden = Orden.find(orden[1])
          @orden.empleado_id = @var["recolector"]
          @orden.estado = "Asignada para Recoleccion"
        @orden.save
        end
      end
    end
    @ordenprincipal = Orden.find(@var["orden"])
    @ordenprincipal.estado = "Asignada para Recoleccion"
    @ordenprincipal.empleado_id = @var["recolector"]
    @ordenprincipal.save
    redirect_to(despachador_path, :notice => t('rutarecolecciones'))

  end

  # Muestra todos los recolectores tanto disponibles como Ocupados y simula
  def recolectores
    @personas = Persona.where(:empleados_id => 2).order("apellido ASC")

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @personas }
    end
  end

  # Metodo muestra las rutas asignadas al recolector
  def ver
    @personas = Persona.find(params["id"])
    @ordenes = Despachar.rutasAsignadas(params["id"])
  end
  
  # Metodo para imprimir todas las ordenes recolectadas para generarles la simulacion
  def simulacion
    @ordenes = Orden.where(:estado => "Recolectada")
  end

  # Borra las las ordnes a despachar
  def destroy
    @despachar = params[:id]
    @direcciones = Despachar.simular(@despachar)
    @entregada = Historico.where(:ordens_id => @despachar, :tipo => 'Entregada').first
    @direcciones.each do |dir|
      @historico= Historico.new(:ordens_id => @despachar, :direccions_id => dir.id, :tipo => 'Llego a: ', :fecha => Time.now)
      @historico.save
    end
    @orden = Orden.find(@despachar)
    @entregada.fecha = Time.now
    @orden.estado = 'Entregada'
    @entregada.save
    @orden.save
  respond_to do |format|
  format.html { redirect_to(simul_path, :notice => t('simulacionexitosa')) }
  format.xml  { head :ok }
  end
  end

end
