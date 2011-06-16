class ServiceController < ApplicationController
  skip_before_filter :verify_authenticity_token
  #http://www.google.com/translate?twu=1&u=http://www.ultrasaurus.com/sarahblog/2009/06/simple-web-services-with-rails/
  #http://www.ultrasaurus.com/sarahblog/2009/06/simple-web-services-with-rails/

  require 'open-uri'
  def show
    @factura = Factura.find(1)
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @historico }
    end
  end

  def prueba #solicita GET

    data = open('http://192.168.0.188:3000/xml/1').read
    # @a = xml_result_set.body
    @a = data
  end
  
  def getorden
    @id = params['id']
    @orden = Orden.find(@id)
    @factura = Factura.where(:ordens_id =>  @id).first
        @monto= @factura.iva + @factura.costoTotal

    @historico = Orden.rutas(@id)
    
        respond_to do |format|
      # format.html # show.html.erb
      format.xml  
    end
  end

end

