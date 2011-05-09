class CourierController < ApplicationController
	layout "enSistema" , :except => [:index]
	def index
		destruir
	  @remote_ip = request.ip
	end

	def contenido

		if  params['openid.mode']=='cancel'
			# render :file => '../views/courier/index'
			redirect_to root_url
		else
			@email=params['openid.ext1.value.email']
			@nombre=params['openid.ext1.value.firstname']
			@apellido=params['openid.ext1.value.lastname']

			if  (@email)
				if !(@persona = Persona.where(:email => @email).first)
					@persona = Persona.new
					render 'personas/new'
				else
					@persona = Persona.where(:email => @email).first
					iniciarSesion(@email,@nombre, @apellido, @persona.id)
				# $email=session[:email]
				# $nombre=session[:nombre] + ' ' + session[:apellido]
				end
			else
				validarSesion
			end
		end

	end

end
