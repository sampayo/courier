class CompaniaController < ApplicationController
  layout "enSistema"

  # GET /compania
  # GET /compania.xml
  # Metodo para el index de compa–ia
  def index
    @compania = Companium.where(:url => nil?)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @compania }
    end
  end

  # GET /compania/1
  # GET /compania/1.xml
  # Metodo para mostrar una compa–ia
  def show
    @companium = Companium.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @companium }
    end
  end

  # GET /compania/new
  # GET /compania/new.xml
  # Metodo para crear una compa–ia
  def new
    @companium = Companium.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @companium }
    end
  end

  # GET /compania/1/edit
  # Metodo para editar una compa–ia
  def edit
    @companium = Companium.find(params[:id])
  end

  # POST /compania
  # POST /compania.xml
  # Metodo para crear una compa–ia
  def create
    @companium = Companium.new(params[:companium])

    respond_to do |format|
      if @companium.save
        format.html { redirect_to(@companium, :notice => t('companiacreada')) }
        format.xml  { render :xml => @companium, :status => :created, :location => @companium }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @companium.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /compania/1
  # PUT /compania/1.xml
  # Metodo para actualizar una compa–ia
  def update
    @companium = Companium.find(params[:id])

    respond_to do |format|
      if @companium.update_attributes(params[:companium])
        format.html { redirect_to(@companium, :notice => t('companiaactualizada')) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @companium.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /compania/1
  # DELETE /compania/1.xml
  def destroy
    @companium = Companium.find(params[:id])
    @companium.destroy

    respond_to do |format|
      format.html { redirect_to(compania_url) }
      format.xml  { head :ok }
    end
  end
end
