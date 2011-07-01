xml.instruct! :xml, :version=>"1.0"

xml.Tracking{
	xml.orden do
		xml.Orden(@orden.id)
		xml.fecha(@orden.fecha)
		xml.Estatus(@orden.estado)
		xml.montototal(@monto)
	end
	
@historico.each do |orden| 
xml.movimiento do
		xml.desc(orden.tipo)
		xml.fecha(orden.fecha)
		xml.nombre(orden.nombre)
		xml.calle(orden.avCalle)
		xml.casa(orden.resCasa)
		xml.numero(orden.aptoNumero)
		xml.urbanizacion(orden.urban)
		xml.ciudad(orden.ciudad)
		xml.pais(orden.pais)
		xml.codigopostal(orden.cPostal)
		xml.lat(orden.lat)
		xml.lng(orden.lng)																		
	end
end


}