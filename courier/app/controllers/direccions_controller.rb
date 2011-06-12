class DireccionsController < ApplicationController
  
  #Llamamos al layout enSistema que se encuentra en la carpeta layouts.
	layout "enSistema"
	
	# Llamada a la pagina index de direccion, siempre y cuando exista una sesion.
	# GET /direccions
	# GET /direccions.xml
	def index
		@direccions = Direccion.where(:personas_id => session[:id])

		respond_to do |format|
			format.html # index.html.erb
			format.xml  { render :xml => @direccions }
		end
	end
  # llamada a motrar una direccion, pasandole un parametro.
	# GET /direccions/1
	# GET /direccions/1.xml
	def show
		@direccion = Direccion.find(params[:id])
		#Accedemos a la constante, para escribir el mensaje en customlog.
    NUESTRO_LOG.info "Estoy viendo la direccion!"
		respond_to do |format|
			format.html # show.html.erb
			format.xml  { render :xml => @direccion }
		end
	end
  # llamada a la pagina new de direccion.
	# GET /direccions/new
	# GET /direccions/new.xml
	def new
		@direccion = Direccion.new

		respond_to do |format|
			format.html # new.html.erb
			format.xml  { render :xml => @direccion }
		end
	end
  # llamada a la pagina edit de direccion.
	# GET /direccions/1/edit
	def edit
		@direccion = Direccion.find(params[:id])
	end
  # Metodo utilizado para crear una direccion.
	# POST /direccions
	# POST /direccions.xml
	def create
		@direccion = Direccion.new(params[:direccion])

		respond_to do |format|
			@direccion.personas_id=session[:id]
			if @direccion.save
				format.html { redirect_to(@direccion, :notice => 'Direccion was successfully created.') }
				format.xml  { render :xml => @direccion, :status => :created, :location => @direccion }
			else
				format.html { render :action => "new" }
				format.xml  { render :xml => @direccion.errors, :status => :unprocessable_entity }
			end
		end
	end
  # Buscamos la direccion por el parametro dado y la mostramos.
	# PUT /direccions/1
	# PUT /direccions/1.xml
	def update
		@direccion = Direccion.find(params[:id])

		respond_to do |format|
			if @direccion.update_attributes(params[:direccion])
				format.html { redirect_to(@direccion, :notice => 'Direccion was successfully updated.') }
				format.xml  { head :ok }
			else
				format.html { render :action => "edit" }
				format.xml  { render :xml => @direccion.errors, :status => :unprocessable_entity }
			end
		end
	end
  # Destruimos una direccion bajo un parametro dado.
	# DELETE /direccions/1
	# DELETE /direccions/1.xml
	def destroy
		@direccion = Direccion.find(params[:id])
		@direccion.destroy

		respond_to do |format|
			format.html { redirect_to(direccions_url) }
			format.xml  { head :ok }
		end
	end
	 def espanol
      I18n.locale = "es"
  end
end
