class Customlog < Logger
  #Metodo el cual le da formato al mesaje que se guarda en /log/customlog
  def format_message(severity, timestamp, progname, msg)
  "#{timestamp.to_formatted_s(:db)} #{severity} #{msg}\n"
  end
end