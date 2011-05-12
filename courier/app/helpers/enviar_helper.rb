module EnviarHelper
	class Direcciones
	  
	  # Metodo helper para obtener el historial de direcciones de un cliente
		def emisor(historico)
			@variable = historico
		end
		def getEmisor
			@variable
		end
	end
end
