class EmpleadosController < ApplicationController
	# GET /empleados
	# GET /empleados.xml
	# Metodo para mostrar los empleados
	def index
		@empleados = Empleado.find(:all)

		respond_to do |format|
			format.html # index.html.erb
			format.xml  { render :xml => @empleados }
		end
	end

	# GET /empleados/1
	# GET /empleados/1.xml
	# Metodos para mostar una empleado
	def show
		@empleado = Empleado.find(params[:id])
		@persona = Persona.find(@empleado.personas_id)
		respond_to do |format|
			format.html # show.html.erb
			format.xml  { render :xml => @empleado }
		end
	end

	# GET /empleados/new
	# GET /empleados/new.xml
	# Metodo para crear un empleado
	def new
		@empleado = Empleado.new
		@query = Persona.find(:all)
		respond_to do |format|
			format.html # new.html.erb
			format.xml  { render :xml => @empleado }
		end
	end

	# GET /empleados/1/edit
	# Metodo para editar un empleado
	def edit
		@query = Persona.find(:all)
		@empleado = Empleado.find(params[:id])
	end

	# POST /empleados
	# POST /empleados.xml
	# Metodo para crear un empleado
	def create
		@empleado = Empleado.new(params[:empleado])

		respond_to do |format|
			if @empleado.save
			  NUESTRO_LOG.info "Se guardo el empleado correctamente"
				format.html { redirect_to(@empleado, :notice => t('empleadocreado')) }
				format.xml  { render :xml => @empleado, :status => :created, :location => @empleado }
			else
				format.html { render :action => "new" }
				format.xml  { render :xml => @empleado.errors, :status => :unprocessable_entity }
			end
		end
	end

	# PUT /empleados/1
	# PUT /empleados/1.xml
	# Metodo para actualizar un empleado
	def update
		@empleado = Empleado.find(params[:id])

		respond_to do |format|
			if @empleado.update_attributes(params[:empleado])
				format.html { redirect_to(@empleado, :notice => t('empleadoactualizado')) }
				format.xml  { head :ok }
			else
				format.html { render :action => "edit" }
				format.xml  { render :xml => @empleado.errors, :status => :unprocessable_entity }
			end
		end
	end

	# DELETE /empleados/1
	# DELETE /empleados/1.xml
	# Metodo para eliminar un empleado
	def destroy
		@empleado = Empleado.find(params[:id])
		@empleado.destroy

		respond_to do |format|
			format.html { redirect_to(empleados_url) }
			format.xml  { head :ok }
		end
	end
end
