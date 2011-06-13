require 'test_helper'

#Falta validar un metodo de orden

class OrdenTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "rutas" do
    @orden = Orden.rutas(298486374)
    assert_not_nil(@orden , NUESTRO_LOG.info("La prueba unitaria OrdenTest(rutas) fue exitosa,retorno la direccion de recoleccion"))
  end

  test "recolectarorden" do
    @orden= Orden.find(298486374)
    @orden.estado = "Pendiente por recolectar"
    @orden.save
    @notice = Orden.rutaRecolectada(@orden)
    assert_equal(@notice , 'La orden se ha recolectado con exito', NUESTRO_LOG.info("La prueba unitaria EnviarTest(recolectarorden) fue exitosa,retornando: #{@notice}"))
  end

  test "recolectarordenrecolectada" do
    @orden= Orden.find(298486374)
    @orden.estado = "Recolectada"
    @orden.save
    @notice = Orden.rutaRecolectada(@orden)
    assert_equal(@notice , 'La orden ya fue recolectada en otro momento', NUESTRO_LOG.info("La prueba unitaria EnviarTest(recolectarordenrecolectada) fue exitosa,retornando: #{@notice}"))
  end

end
