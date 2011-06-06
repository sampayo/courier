require 'test_helper'
#Faltan los 4 metodos por probar!

class EnviarTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "the truth" do
    Despachar.ordenesCercanas(id,lat,lng)
    Despachar.orden(id)
    Despachar.recolectorDesocupado
    Despachar.rutasAsignadas(id)
    assert true
  end
end