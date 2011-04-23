class TipoPagosController < ApplicationController
	layout "enSistema"
	# GET /tipo_pagos
	# GET /tipo_pagos.xml
	def index
		@tipo_pagos = TipoPago.where(:personas_id => session[:id])
		respond_to do |format|
			format.html # index.html.erb
			format.xml  { render :xml => @tipo_pagos }
		end
	end

	# GET /tipo_pagos/1
	# GET /tipo_pagos/1.xml
	def show
		@tipo_pago = TipoPago.find(params[:id])

		respond_to do |format|
			format.html # show.html.erb
			format.xml  { render :xml => @tipo_pago }
		end
	end

	# GET /tipo_pagos/new
	# GET /tipo_pagos/new.xml
	def new
		@tipo_pago = TipoPago.new

		respond_to do |format|
			format.html # new.html.erb
			format.xml  { render :xml => @tipo_pago }
		end
	end

	# GET /tipo_pagos/1/edit
	def edit
		@tipo_pago = TipoPago.find(params[:id])
	end

	# POST /tipo_pagos
	# POST /tipo_pagos.xml
	def create
		@tipo_pago = TipoPago.new(params[:tipo_pago])

		respond_to do |format|
			@tipo_pago.personas_id=session[:id]
			if @tipo_pago.save
				format.html { redirect_to(@tipo_pago, :notice => 'Tipo pago was successfully created.') }
				format.xml  { render :xml => @tipo_pago, :status => :created, :location => @tipo_pago }
			else
				format.html { render :action => "new" }
				format.xml  { render :xml => @tipo_pago.errors, :status => :unprocessable_entity }
			end
		end
	end

	# PUT /tipo_pagos/1
	# PUT /tipo_pagos/1.xml
	def update
		@tipo_pago = TipoPago.find(params[:id])

		respond_to do |format|
			if @tipo_pago.update_attributes(params[:tipo_pago])
				format.html { redirect_to(@tipo_pago, :notice => 'Tipo pago was successfully updated.') }
				format.xml  { head :ok }
			else
				format.html { render :action => "edit" }
				format.xml  { render :xml => @tipo_pago.errors, :status => :unprocessable_entity }
			end
		end
	end

	# DELETE /tipo_pagos/1
	# DELETE /tipo_pagos/1.xml
	def destroy
		@tipo_pago = TipoPago.find(params[:id])
		@tipo_pago.destroy

		respond_to do |format|
			format.html { redirect_to(tipo_pagos_url) }
			format.xml  { head :ok }
		end
	end
end
