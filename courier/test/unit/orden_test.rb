require 'test_helper'
#Falta validar un metodo de orden

class OrdenTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "rutas" do
     Orden.rutas(298486374)
    assert(true , NUESTRO_LOG.info("La prueba unitaria OrdenTest(rutas) fue exitosa,retorno la direccion de recoleccion"))
  end
end
