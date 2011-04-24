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
						format.html { redirect_to(ordens_path, :notice => 'Historico was successfully created.') }
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
	

end

