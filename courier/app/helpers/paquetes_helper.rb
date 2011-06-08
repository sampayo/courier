module PaquetesHelper
  
  def validar (id)
    
    @paquete = Paquete.where(:ordens_id => nil, :personas_id => id).first
    if @paquete.nil?
      @paquete =  ""
    else
      @paquete = link_to t('generarorden'), enviar_path(id)
    end
  end
  
end
