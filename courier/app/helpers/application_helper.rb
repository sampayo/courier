module ApplicationHelper
  def idioma(dir)
    @dir=request.url
    @dirSplit=@dir.split('/')
    @direccion = ''
    @dirSplit.each do |direccion|
      if @direccion == ''
      @direccion= @direccion + direccion
      else
        if direccion == 'es' || direccion == 'en'
          @direccion= @direccion + '/' + dir
        else
          @direccion= @direccion + '/' + direccion
        end
      end
    end
    @direccion
  end
end
