require "open-uri"
pdf.font "Helvetica"


pdf = Prawn::Document.new(:page_layout => :portrait,  :page_size => 'A4')

 pdf.move_down 30       
pdf.text "#{@compania.nombre}",
      :size => 21,
      :align => :right,
      :style => :bold   
pdf.text "#{@compania.rif}",
      :size => 15,
      :align => :right,
      :style => :bold
pdf.move_down 10        
pdf.text "direccion: #{@compania.direccionF}", :size => 10, :align => :right
pdf.text "Telefono: #{@compania.telefono}", :size => 10, :align => :right
pdf.move_down 30   

pdf.text "#{@cliente.nombre} #{@cliente.apellido}", :size => 21, :align => :left, :style => :bold
pdf.text "#{@cliente.email}", :size => 15, :align => :left
pdf.move_down 20 
table2 = [["","","Orden #: " ,"#{@orden.id}"] , ["","","fecha", "#{@orden.fecha}"],["","","Receptor", "#{@orden.nombre} #{@orden.apellido}"]]
pdf.table(table2,  :column_widths => { 0 => 80, 1 => 200, 2 => 60, 3 => 150 }, :cell_style => { :borders => [] })  
pdf.move_down 20 


top = [["Item", "Descripcion" ,"Peso (g)"," "]]
items = @paquete.map do |paquete| 
  [  
        paquete.nombre,  
        paquete.descripcion,
        paquete.peso,
        ""   
  ]  
end  

pdf.table top, :row_colors => ["d2e3ed"], :column_widths => { 0 => 80, 1 => 200, 2 => 60, 3 => 150 }
pdf.table items, :row_colors => ["FFFFFF"], :column_widths => { 0 => 80, 1 => 200, 2 => 60, 3 => 150}
fin = [["","","Subtotal","#{@factura.costoTotal}"],["","","iva","#{@factura.iva.round(2)}"],["","","Total","#{@total.round(2)}"]]
pdf.table fin, :row_colors => ["FFFFFF"], :column_widths => { 0 => 80, 1 => 200, 2 => 60, 3 => 150}

pdf.move_down 30 


pdf.font_size 22
pdf.text "Codigo QR", :align => :center
pdf.move_down 20

pdf.image open("#{@dirQR}"), :position => :center
