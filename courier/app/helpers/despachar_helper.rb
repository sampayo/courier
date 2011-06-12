module DespacharHelper
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
  
  def validarDisponibilidad(id)
    @orden = Orden.where(:empleado_id => id).first
    if @orden.nil?
      "Disponible"
    else
      link_to t('verruta') ,ver_path(id)
    end
  end
end
