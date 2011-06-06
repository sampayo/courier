#Variables que se encargan de abrir el customlog y sincronizarlo.
nuestro_custom_log = File.open("#{RAILS_ROOT}/log/customlog.log", 'a')
nuestro_custom_log.sync = true
#Constante la cual utilizamos para escribir en customlog. de la misma forma que hariamos con Rails.log.
NUESTRO_LOG = Customlog.new(nuestro_custom_log)