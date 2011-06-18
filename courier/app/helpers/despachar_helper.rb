module DespacharHelper
  
  # Metodo para validar las ordenes cercanas a un paquete
  def descripcionDir(direcciones)
    @bolean = false
    if direcciones.nil?
      @imprime = t('noordenescercanas')
    else
      direcciones.each do |orden|
        if orden.distancia < 0.1
        @bolean = true
        end
      end
      if @bolean
        @imprime = t('ordenescerca')
      else
        @imprime = t('noordenescercanas')
      end
    end
  end
  
  # Metodo para validar la disponibilidad del recolector
  def validarDisponibilidad(id)
    @orden = Orden.where(:empleado_id => id).first
    if @orden.nil?
      t('disponible')
    else
      link_to t('verruta') ,ver_path(id)
    end
  end
end
