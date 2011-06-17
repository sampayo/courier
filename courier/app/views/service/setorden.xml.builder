xml.instruct! :xml, :version=>"1.0"

xml.Tracking{
	xml.info do
		xml.tracking(@cliente)
		xml.orden(@orden)
		xml.orden(@recoleccion)
		xml.orden(@entrega)
	end

}