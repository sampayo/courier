class AdminController < ApplicationController

  # Llamamos al layout enSistema que se encuentra en la carpeta layouts.
  layout "enSistema"
  # GET /personas
  # GET /personas.xml
  def index
    @personas = Persona.where(:empleados_id => nil)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @personas }
    end
  end

  # GET /personas/1
  # GET /personas/1.xml
  def show
    @persona = Persona.find(params[:id])
   
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @persona }
    end
  end

  # GET /personas/new
  # GET /personas/new.xml
  # Metodo para mostrar los administrador
  def new
    @persona = Persona.new
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @persona }
    end
  end

  # GET /personas/1/edit
  def edit
    @persona = Persona.find(params[:id])
  end

  # POST /personas
  # POST /personas.xml
  # Metodo para crear administrador
  def create
    @persona = Persona.new(params[:persona])

    respond_to do |format|
      if @persona.save
        NUESTRO_LOG.info "Se guardo el administrador correctamente"
        format.html { redirect_to(admin_path(@persona), :notice => t('admincreado')) }
        format.xml  { render :xml => @persona, :status => :created, :location => @persona }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @persona.errors, :status => :unprocessable_entity }
      end
    end

  end

  # PUT /personas/1
  # PUT /personas/1.xml
  # Metodo para actualizar administrador
  def update
    @persona = Persona.find(params[:id])

    respond_to do |format|
      if @persona.update_attributes(params[:persona])
        format.html { redirect_to(admin_path(@persona), :notice => t('adminactualizado')) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @persona.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /personas/1
  # DELETE /personas/1.xml
  # Metodo encargado de borrar Administradores
  def destroy
    @persona = Persona.find(params[:id])
    @persona.destroy

    respond_to do |format|
      format.html { redirect_to(emple_path) }
      format.xml  { head :ok }
    end
  end
  
  # Metodo el cual trae los diferentes tipos de empleados
  def empleados
    @personas = Persona.where(:empleados_id => [2,3,1]).order(:empleados_id)
  end
end

