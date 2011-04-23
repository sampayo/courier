class CompaniaController < ApplicationController
  # GET /compania
  # GET /compania.xml
  def index
    @compania = Companium.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @compania }
    end
  end

  # GET /compania/1
  # GET /compania/1.xml
  def show
    @companium = Companium.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @companium }
    end
  end

  # GET /compania/new
  # GET /compania/new.xml
  def new
    @companium = Companium.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @companium }
    end
  end

  # GET /compania/1/edit
  def edit
    @companium = Companium.find(params[:id])
  end

  # POST /compania
  # POST /compania.xml
  def create
    @companium = Companium.new(params[:companium])

    respond_to do |format|
      if @companium.save
        format.html { redirect_to(@companium, :notice => 'Companium was successfully created.') }
        format.xml  { render :xml => @companium, :status => :created, :location => @companium }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @companium.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /compania/1
  # PUT /compania/1.xml
  def update
    @companium = Companium.find(params[:id])

    respond_to do |format|
      if @companium.update_attributes(params[:companium])
        format.html { redirect_to(@companium, :notice => 'Companium was successfully updated.') }
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
