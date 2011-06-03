class DespacharController < ApplicationController
  layout "enSistema"
  # GET /historicos
  # GET /historicos.xml
  def index
    @ordens = Orden.where(:estado => "Pendiente por Recolectar").order("created_at DESC")
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @ordens }
    end
  end

  # GET /historicos/1
  # GET /historicos/1.xml
  def show
    @orden = Despachar.orden(params[:id])
    @recolector = Despachar.recolectorDesocupado
    @direccionCercana= Despachar.ordenesCercanas(params[:id],@orden.lat,@orden.lng)
    @count=0
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @ordens }
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
    redirect_to(despachador_path, :notice => 'La ruta de recoleccion fue asignada con exito.')

  end

  # PUT /historicos/1
  # PUT /historicos/1.xml
  # def update
    # @historico = Historico.find(params[:id])
# 
    # respond_to do |format|
      # if @historico.update_attributes(params[:historico])
        # format.html { redirect_to(@historico, :notice => 'Historico was successfully updated.') }
        # format.xml  { head :ok }
      # else
        # format.html { render :action => "edit" }
        # format.xml  { render :xml => @historico.errors, :status => :unprocessable_entity }
      # end
    # end
  # end

  # DELETE /historicos/1
  # DELETE /historicos/1.xml
  # def destroy
    # @historico = Historico.find(params[:id])
    # @historico.destroy
# 
    # respond_to do |format|
      # format.html { redirect_to(historicos_url) }
      # format.xml  { head :ok }
    # end
  # end

  # Muestra todos los recolectores tanto disponibles como Ocupados y simula
  def recolectores
    @personas = Persona.where(:empleados_id => 2).order("apellido ASC")

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @personas }
    end
  end

  def ver
    @personas = Persona.find(params["id"])
    @ordenes = Despachar.rutasAsignadas(params["id"])
  end
  
  def simulacion
    @ordenes = Orden.where(:estado => "Recolectada") 
  end

end
