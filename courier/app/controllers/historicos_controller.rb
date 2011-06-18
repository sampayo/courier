class HistoricosController < ApplicationController
  # GET /historicos
  # GET /historicos.xml
  # Metodo muesta el index de historico
  def index
    @historico = Historico.all

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @historico }
    end
  end

  # GET /historicos/1
  # GET /historicos/1.xml
  # Metodo que muestra un historico
  def show
    @historico = Historico.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @historico }
    end
  end

  # GET /historicos/new
  # GET /historicos/new.xml
  # Metodo para crear un historico
  def new
    @historico = Historico.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @historico }
    end
  end

  # GET /historicos/1/edit
  # Metodo para editar un historico
  def edit
    @historico = Historico.find(params[:id])
  end

  # POST /historicos
  # POST /historicos.xml
  # Metodo para crear un historico
  def create
    @historico = Historico.new(params[:historico])

    respond_to do |format|
      if @historico.save
        format.html { redirect_to(@historico, :notice => t('historicocreado')) }
        format.xml  { render :xml => @historico, :status => :created, :location => @historico }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @historico.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /historicos/1
  # PUT /historicos/1.xml
  # Metodo para actualizar un historico
  def update
    @historico = Historico.find(params[:id])

    respond_to do |format|
      if @historico.update_attributes(params[:historico])
        format.html { redirect_to(@historico, :notice => t('historicoactualizado')) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @historico.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /historicos/1
  # DELETE /historicos/1.xml
  # Metodo para eliminar un historico
  def destroy
    @historico = Historico.find(params[:id])
    @historico.destroy

    respond_to do |format|
      format.html { redirect_to(historicos_url) }
      format.xml  { head :ok }
    end
  end
end
