module OrdensHelper
  # Metodo para validar que el ID de la orden concuerde con el usuario.
  def validarOrden (id)
    @historico = Historico.where(:ordens_id => id , :tipo => 'inicio').first
    if @historico.nil?
      @historico = link_to t('enviar'), enviar_path(id)
    else
      @historico = 'Enviado'
    end
  end

  def retorno(id)
    @persona = Persona.find(id)
    if @persona.empleados_id.nil?
      link_to t('regresar'), ordens_path
    else
      link_to t('regresar'), despachador_path
    end
  end

end
