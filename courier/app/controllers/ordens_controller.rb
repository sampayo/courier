class OrdensController < ApplicationController
  
  # Llamamos al layout enSistema que se encuentra en la carpeta layouts.
	layout "enSistema"
	# GET /ordens
	# GET /ordens.xml
	
	# Metodo llamado al iniciar la pagina index, y muestra la pagina unicamente si existe session.
	def index
		@ordens = Orden.where(:personas_id => session[:id]).order("created_at DESC")
		respond_to do |format|
			format.html # index.html.erb
			format.xml  { render :xml => @ordens }
		end
	end

  # llamada a motrar una orden, pasandole un parametro, y buscando un paquete que use este parametro.
	# GET /ordens/1
	# GET /ordens/1.xml
	def show
		@orden = Orden.find(params[:id])
		@paquetes = Paquete.where(:ordens_id => params[:id] )
		
		# Realizamos dos llamadas a buscar en base de datos para poder crear las facturas del usuario.
      @historico = Historico.find_by_sql('Select h.fecha, h.tipo , d.ciudad, d.cPostal from historicos h, direccions d where h.direccions_id=d.id and h.fecha is not null and h.ordens_id=' + @orden.id.to_s + ' order by h.fecha DESC')
    # Comparamos que ambas llamadas a base de datos sean iguales y creamos dos salidas para la factura.
		if @salida && @destino
			@salida=@salida.ciudad + ', ' + @salida.pais + ' Urbanizacion: ' + @salida.urban + ' Residencia: ' + @salida.resCasa
			@destino=@destino.ciudad + ', ' + @destino.pais + ' Urbanizacion: ' + @destino.urban + ' Residencia: ' + @destino.resCasa
		end

		respond_to do |format|
			format.html # show.html.erb
			format.xml  { render :xml => @orden }
		end
	end

  # llamada a la pagina new de orden, pasandole un parametro y preguntando un parametro de la session del usuario.
	# GET /ordens/new
	# GET /ordens/new.xml
	def new
		if (Direccion.where(:personas_id => session[:id]).first && TipoPago.where(:personas_id => session[:id]).first)
			@orden = Orden.new
			respond_to do |format|
				format.html # new.html.erb
				format.xml  { render :xml => @orden }
			end
		else
		  # Mostramos un error, de no existir una tarjeta de credito y una direcion.
			flash[:error] = "Para hacer una orden debe tener al menos una direccion y una tarjeta de credito"
			redirect_to cont_path
		end
	end

  # Llamamos a la pagina editar de orden.
	# GET /ordens/1/edit
	def edit
		@orden = Orden.find(params[:id])
	end

  # llamada a crear una orden, pasandole un parametro, y preguntando por la sesion del usuario, la fecha actual,
  # fijamos un estado de la orden.
	# POST /ordens
	# POST /ordens.xml
	def create
		@orden = Orden.new(params[:orden])
		@orden.personas_id=session[:id]
		@orden.fecha= Time.now
		@orden.estado = 'Pendiente por enviar'
		respond_to do |format|
			if @orden.save
				format.html { redirect_to(@orden, :notice => 'Orden was successfully created.') }
				format.xml  { render :xml => @orden, :status => :created, :location => @orden }
			else
				format.html { render :action => "new" }
				format.xml  { render :xml => @orden.errors, :status => :unprocessable_entity }
			end
		end
	end

  # Llamamos al metodo para acualiar la orden pasandole un parametro.
	# PUT /ordens/1
	# PUT /ordens/1.xml
	def update
		@orden = Orden.find(params[:id])

		respond_to do |format|
			if @orden.update_attributes(params[:orden])
				format.html { redirect_to(@orden, :notice => 'Orden was successfully updated.') }
				format.xml  { head :ok }
			else
				format.html { render :action => "edit" }
				format.xml  { render :xml => @orden.errors, :status => :unprocessable_entity }
			end
		end
	end

  # Llamada al metodo destruir, para borrar una orden, pasandole un parametro.
	# DELETE /ordens/1
	# DELETE /ordens/1.xml
	def destroy
		@orden = Orden.find(params[:id])
		@orden.destroy

		respond_to do |format|
			format.html { redirect_to(ordens_url) }
			format.xml  { head :ok }
		end
	end
end
