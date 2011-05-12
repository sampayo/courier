module OrdensHelper
	
	# Metodo para validar que el ID de la orden concuerde con el usuario.
	def validarOrden (id)
		@historico = Historico.where(:ordens_id => id , :tipo => 'inicio').first
		if @historico.nil?
			@historico = link_to 'Enviar', enviar_path(id)
		else
			@historico = 'Enviado'
		end
	end
	
end
