require 'test_helper'

#Faltan los 4 metodos por probar!

class DespacharTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "ordenesCercanas" do
    @ordenescerca = Despachar.ordenesCercanas(298486374,1.51,1.51)
    assert_not_nil(@ordenescerca , NUESTRO_LOG.info("La prueba unitaria DespacharTest(ordenesCercanas) fue exitosa,retorno las direcciones con una distancia"))
  end

  test "orden" do
    @orden = Orden.find(298486374)
    @orden.estado = 'Pendiente por recolectar'
    @orden.save
    @algo = Despachar.orden(298486374)
    assert_not_nil(@algo , NUESTRO_LOG.info("La prueba unitaria DespacharTest(orden) fue exitosa,retorno la orden con su direccion y fehca de recoleccion"))
  end

  test "recolectorDesocupado" do
    @recolectores = Despachar.recolectorDesocupado
    assert_not_nil(@recolectores.first,NUESTRO_LOG.info("La prueba unitaria DespacharTest(recolectorDesocupado) fue exitosa, por que retorno empleados disponibles"))
  end

  test "recolectorOcupado" do
    @orden = Orden.find(298486374)
    @orden.empleado_id = 3
    @orden.save
    @recolectores = Despachar.recolectorDesocupado
    assert_nil(@recolectores.first,NUESTRO_LOG.info("La prueba unitaria DespacharTest(recolectorOcupado) fue exitosa, por que no hay recolectores disponibles"))
  end

  test "rutaasignada" do
    @dir = Despachar.rutasAsignadas(298486374)
    assert_not_nil(@dir , NUESTRO_LOG.info("La prueba unitaria DespacharTest(rutaasignada) fue exitosa, por que retorno direcciones disponibles y agrego 2 mas"))
  end

end