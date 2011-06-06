module AdminHelper
  def cargo(id)
    if id==2
      t('principal.recolectar')
    else
      if id==3
        t('principal.despachar')
      else
        if id==1
          t('principal.admin')
        end
      end
    end

  end

end
