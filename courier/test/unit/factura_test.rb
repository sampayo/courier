require 'test_helper'

class FacturaTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "facturatotal" do
    @factura = Factura.facturatotal(298486374)
    assert_not_nil(@factura ,NUESTRO_LOG.info("La prueba unitaria FacturaTest(facturatotal) fue exitosa"))
  end
end
