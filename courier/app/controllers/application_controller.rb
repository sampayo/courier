class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :set_locale
  def set_locale
    # if params[:locale] is nil then I18n.default_locale will be used
    I18n.locale = params[:locale]
  end

  def default_url_options(options={})
    logger.debug "default_url_options is passed options: #{options.inspect}\n"
    { :locale => I18n.locale }
  end

  #Metodo con el cual iniciamos sesion.
  #Necesitamos de 4 atributos los cuales los recibimos del session
  #Colocamos el email del usuario y el nombre en la pagina una vez que se inicia la sesion.
  def iniciarSesion (email,nombre,apellido,id)
    session[:email] = email
    session[:nombre] = nombre
    session[:apellido] = apellido
    session[:id] = id
  end

  #Metodo para destruir la sesion una vez que el usuario utiliza el boton de salir.
  #Colocamos todos los atributos de sesion en null.
  def destruir
    session[:email]=nil
    session[:nombre]=nil
    session[:apellido]=nil
    $email=''
    $nombre=''
  end

  #Metodo para validar si existe una session activa.
  def validarSesion
    if  session[:email].nil?
      flash[:error] = "Debe iniciar sesion"
      redirect_to root_url
    end
  end

  #Metodo para que la IP del servidor cambie automaticamente al de la maquina donde se esta desarrollando
  #Esto para que la IP a la cual el OpenID retorna la informacion del usuario concuerde con el de nosotros.
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
