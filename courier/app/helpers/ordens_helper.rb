module OrdensHelper
	
	def validarOrden (id)
		@historico = Historico.where(:ordens_id => id , :tipo => 'inicio').first
		if @historico.nil?
			@historico = link_to 'Enviar', enviar_path(id)
		else
			@historico = 'Enviado'
		end
	end
	
end
