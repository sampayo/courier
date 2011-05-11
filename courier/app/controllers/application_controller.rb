class ApplicationController < ActionController::Base
	protect_from_forgery
	
	
	def iniciarSesion (email,nombre,apellido,id)
		session[:email] = email
		session[:nombre] = nombre
		session[:apellido] = apellido
		session[:id] = id
		$email = email
		$nombre = nombre +" "+ apellido
	end

	def destruir
		session[:email]=nil
		session[:nombre]=nil
		session[:apellido]=nil
		$email=''
		$nombre=''
	end

	def validarSesion
		if  session[:email].nil?
			flash[:error] = "Debe iniciar sesion"
			redirect_to root_url
		end
	end
	
	 def ip
      orig, Socket.do_not_reverse_lookup = Socket.do_not_reverse_lookup, true # turn off reverse DNS resolution temporarily
      UDPSocket.open do |s|
        s.connect '64.233.187.99', 1
        s.addr.last
      end
      ensure
      Socket.do_not_reverse_lookup = orig
    end
	

end
