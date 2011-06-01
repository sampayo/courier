module DespacharHelper
  def descripcionDir(direcciones)
    @bolean = false
    if direcciones.nil?
      @imprime = "No hay ordenes cercanas"
    else
      direcciones.each do |orden|
        if orden.distancia < 0.1
        @bolean = true
        end
      end
      if @bolean
        @imprime = "Estas ordenes estan cercanas a su orden, puede asignarlas a la ruta de recoleccion"
      else
        @imprime = "No hay Ordenes cercanas"
      end
    end
  end
end
