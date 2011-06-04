nuestro_custom_log = File.open("#{RAILS_ROOT}/log/customlog.log", 'a')
nuestro_custom_log.sync = true
NUESTRO_LOG = Customlog.new(nuestro_custom_log)