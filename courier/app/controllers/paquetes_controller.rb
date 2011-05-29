class PaquetesController < ApplicationController

  # Llamamos al layout enSistema que se encuentra en la carpeta layouts.
  layout "enSistema"
  # Metodo utilizado cuando se accede a la pagina index.
  # GET /paquetes
  # GET /paquetes.xml
  def index
    @id=session[:id]
    @paquetes = Paquete.where(:personas_id => @id,:ordens_id => nil)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @paquetes }
    end
  end

  # llamada a motrar una paquete, pasandole un parametro.
  # GET /paquetes/1
  # GET /paquetes/1.xml
  def show
    @paquete = Paquete.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @paquete }
    end
  end

  # llamada a la pagina new de paquete, pasandole un parametro
  # GET /paquetes/new
  # GET /paquetes/new.xml
  def new

    @paquete = Paquete.new
    @orden = params[:id]
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @paquete }
    end
  end

  # Llamamos a la pagina editar de paquete.
  # GET /paquetes/1/edit
  def edit
    @paquete = Paquete.find(params[:id])
  end

  # llamada a crear una paquete, pasandole un parametro.
  # POST /paquetes
  # POST /paquetes.xml
  def create
    @paquete = Paquete.new(params[:paquete])
    respond_to do |format|
      @paquete.personas_id=session[:id]
      if @paquete.save
        format.html { redirect_to(@paquete, :notice => 'Paquete was successfully created.') }
        format.xml  { render :xml => @paquete, :status => :created, :location => @paquete }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @paquete.errors, :status => :unprocessable_entity }
      end
    end
  end

  # Llamamos al metodo para acualizar la paquete pasandole un parametro.
  # PUT /paquetes/1
  # PUT /paquetes/1.xml
  def update
    @paquete = Paquete.find(params[:id])

    respond_to do |format|
      if @paquete.update_attributes(params[:paquete])
        format.html { redirect_to(@paquete, :notice => 'Paquete was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @paquete.errors, :status => :unprocessable_entity }
      end
    end
  end

  # Llamada al metodo destruir un paquete, pasandole un parametro.
  # DELETE /paquetes/1
  # DELETE /paquetes/1.xml
  def destroy
    @paquete = Paquete.find(params[:id])
    @paquete.destroy

    respond_to do |format|
      format.html { redirect_to(@paquete) }
      format.xml  { head :ok }
    end
  end
end
