require 'test_helper'

class HistoricoTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "seguimientopaquete" do
    @nonulo = Historico.seguimiento1(298486374)
    assert_not_nil(@nonulo, NUESTRO_LOG.info("El test me retorno una orden de seguimiento valida existente"))
  end
end
