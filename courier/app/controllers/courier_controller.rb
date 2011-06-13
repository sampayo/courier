class CourierController < ApplicationController
  #Llamamos al layout enSistema que se encuentra en la carpeta layouts, excepto al index.
  layout "enSistema" , :except => [:index , :seguimiento ]
  # Llamada a la pagina index (Pagina principal).
  def index
    # llamada al metodo destruir que se encuentra en application_controller.rb
    destruir
    # Llamada al metodo ip que se encuetra dentro de application_controller.rb y lo asignamos a la variable.
    @remote_ip = ip
  end

  # Metodo utilizado para extraer la informacion que trae OpenID por Get.
  def contenido

    if  params['openid.mode']=='cancel'
      # render :file => '../views/courier/index'
      redirect_to root_url
    else
    # Buscamos los siguientes parametros dentro del Url del OpenID
      @email=params['openid.ext1.value.email']
      @nombre=params['openid.ext1.value.firstname']
      @apellido=params['openid.ext1.value.lastname']

      # Preguntamos si los parametros que nos trae el Url ya se encuentran registrados en la Base de Datos
      if  (@email)
        # Si la persona no se encuentra la agregamos en el IF, si no llamamos a iniciar session con los parametros del Url.
        if !(@persona = Persona.where(:email => @email).first)
          @persona = Persona.new
          render 'personas/new'
        else
          @persona = Persona.where(:email => @email).first
          iniciarSesion(@email,@nombre, @apellido, @persona.id)
        end
      else
      # Llamamos al metodo validarSesion que se encuentra en application_controller.rb.
        validarSesion
      end
    end

  end

  def seguimiento
    @remote_ip = ip
    @busqueda = params['s'] 
    if !(Orden.where(:id => @busqueda).first.nil?)
      @orden = Orden.find(@busqueda)
      @historico = Historico.seguimiento1(@orden.id)
    else
      redirect_to (root_url)
    end
  end

end
