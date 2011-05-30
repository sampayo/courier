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
    @ordens = Orden.find(params[:id])
  @ordencompare = Orden.where(:estado => "Pendiente por Recolectar")
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
  def edit
    @historico = Historico.find(params[:id])
  end

  # POST /historicos
  # POST /historicos.xml
  def create
    @historico = Historico.new(params[:historico])

    respond_to do |format|
      if @historico.save
        format.html { redirect_to(@historico, :notice => 'Historico was successfully created.') }
        format.xml  { render :xml => @historico, :status => :created, :location => @historico }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @historico.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /historicos/1
  # PUT /historicos/1.xml
  def update
    @historico = Historico.find(params[:id])

    respond_to do |format|
      if @historico.update_attributes(params[:historico])
        format.html { redirect_to(@historico, :notice => 'Historico was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @historico.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /historicos/1
  # DELETE /historicos/1.xml
  def destroy
    @historico = Historico.find(params[:id])
    @historico.destroy

    respond_to do |format|
      format.html { redirect_to(historicos_url) }
      format.xml  { head :ok }
    end
  end

end
