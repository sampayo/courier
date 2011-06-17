xml.instruct! :xml, :version=>"1.0"

xml.Tracking{
	xml.info do
		xml.tracking(@orden.id)
		xml.monto(@monto)
		xml.iva(@iva)
		xml.montoTotal(@montototal)
	end

}