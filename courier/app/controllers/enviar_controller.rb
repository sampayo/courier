class EnviarController < ApplicationController
	layout "enSistema"
	include EnviarHelper
	# POST /historicos
	# POST /historicos.xml
	def create
		@enviar = params[:enviar]
		@historico1= Historico.new(:ordens_id => @enviar['ordens_id'], :direccions_id => @enviar['direccions_id'], :tipo => 'inicio', :fecha=> Time.now)
		@historico= Historico.new(:ordens_id => @enviar['ordens_id'], :direccions_id => @enviar['direccions'], :tipo => 'fin')

		# redirect_to ordens_path
		respond_to do |format|
			if @historico1.save && @historico.save
				format.html { redirect_to(tipoPago_path(@enviar['ordens_id']), :notice => 'Historico was successfully created.') }
				format.xml  { render :xml => @historico, :status => :created, :location => @historico }
			else
				format.html { render :action => "new" }
				format.xml  { render :xml => @historico.errors, :status => :unprocessable_entity }
			end
		end
	end

	def show
		@direccions = Direccion.where(:personas_id => session[:id])
		@enviar = Historico.new
		@orden=params[:id]

		respond_to do |format|
			format.html # show.html.erb
			format.xml  { render :xml => @historico }
		end
	end

	def tipoPago
		@orden=params[:id]
		@tipo_pagos = TipoPago.where(:personas_id => session[:id])
		respond_to do |format|
			format.html # index.html.erb
			format.xml  { render :xml => @tipo_pagos }
		end
	end
	
	def montoTotal(id)
		@orden = Orden.find(id)
		@monto=0
		@paquetes = Paquete.where(:ordens_id => id)
		@paquetes.each do |paquete|
			@monto=paquete.peso + @monto
		end
		
		@lala=@monto
	end

	def factura
		@enviar = params[:enviar]
		montoTotal(@enviar['ordens_id'])
		
		# @tipo_pago = Facturas.new(:ordens_id => @enviar['ordens_id'], :direccions_id => @enviar['direccions_id'], :tipo => 'inicio', :fecha=> Time.now)

		#respond_to do |format|
			#@tipo_pago.personas_id=session[:id]
			# if @tipo_pago.save
			# 	# format.html { redirect_to(@tipo_pago, :notice => 'Tipo pago was successfully created.') }
			# 	format.xml  { render :xml => @tipo_pago, :status => :created, :location => @tipo_pago }
			# else
			# 	format.html { render :action => "new" }
			# 	format.xml  { render :xml => @tipo_pago.errors, :status => :unprocessable_entity }
			# end
		#end
	end

end

