class EnviarController < ApplicationController
	layout "enSistema"
	include EnviarHelper
	def index
		@direccions = Direccion.where(:personas_id => session[:id])
		@historico = Historico.new
		@direcciones=Direcciones.new
		
		@orden=params[:id]
		# emisor(@historico.ordens_id=params[:id])
		respond_to do |format|
			format.html # new.html.erb
			format.xml  { render :xml => @historico }
		end
	end

	# GET /historicos/1/edit

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
end

