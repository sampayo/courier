class OrdensController < ApplicationController
	layout "enSistema"
	# GET /ordens
	# GET /ordens.xml
	def index
		@ordens = Orden.where(:personas_id => session[:id])	
		respond_to do |format|
			format.html # index.html.erb
			format.xml  { render :xml => @ordens }
		end
	end

	# GET /ordens/1
	# GET /ordens/1.xml
	def show
		@orden = Orden.find(params[:id])
		@paquetes = Paquete.where(:ordens_id => params[:id] )
		@destino = Direccion.find_by_sql("select * from historicos h, direccions d where d.id=h.direccions_id and h.tipo='fin' and h.ordens_id=" + params[:id]).first
		@salida = Direccion.find_by_sql("select * from historicos h, direccions d where d.id=h.direccions_id and h.tipo='inicio' and h.ordens_id=" + params[:id]).first

		if @salida && @destino
			@salida=@salida.ciudad + ', ' + @salida.pais + ' Urbanizacion: ' + @salida.urban + ' Residencia: ' + @salida.resCasa
			@destino=@destino.ciudad + ', ' + @destino.pais + ' Urbanizacion: ' + @destino.urban + ' Residencia: ' + @destino.resCasa
		end

		respond_to do |format|
			format.html # show.html.erb
			format.xml  { render :xml => @orden }
		end
	end

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
			flash[:error] = "Para hacer una orden debe tener al menos una direccion y una tarjeta de credito"
			redirect_to cont_path
		end
	end

	# GET /ordens/1/edit
	def edit
		@orden = Orden.find(params[:id])
	end

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
