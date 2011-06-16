require 'test_helper'

#Falta un metodo por probar!

class EnviarTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "monto" do
    @monto = Enviar.montoTotal(298486374)
    assert_not_nil(@monto , NUESTRO_LOG.info("el monto de la prueba unitaria (EnviarTest(monto)) es #{@monto}"))
  end
  
    test "monto2" do
    @monto = Enviar.montoTotal(298486374)
    assert_equal(@monto ,50.0, NUESTRO_LOG.info("el monto de la prueba unitaria (EnviarTest(monto2)) retorno el monto correcto"))
  end

  test "recolectar" do
    Enviar.validarRecoleccion(298486374)
    @orden = Orden.find(298486374)
    assert_equal(@orden.estado , 'Recolectada', NUESTRO_LOG.info("La prueba unitaria EnviarTest(recolectar) fue exitosa,cambio el estado a recolectado"))
  end

  test "factura" do
    @factura = Enviar.facturaxml(298486374)
    assert_not_nil(@factura ,NUESTRO_LOG.info("La prueba unitaria EnviarTest(factura) fue exitosa"))
  end

  test "compania" do
    Enviar.compania
    assert true
  end
end