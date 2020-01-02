require 'logging'

module Multidapter
  module Log

    Logging.init :debug, :info, :trace, :warn, :success, :error, :fatal

    Logging.appenders.graylog 'graylog-server'
    {
      server: 'localhost',
      level:  'DEBUG',
      port:   '12201'
    }


    Logging.color_scheme( 'soothing_ish',
                          :levels => {
                            :info  => :cyan,
                            :trace => :green,
                            :warn  => :yellow,
                            :success => [:blue],
                            :error => :red,
                            :fatal => [:white, :on_red]
                          },
                          :date => :cyan,
                          :logger => :cyan,
                          :message => :orange
                          )

    Logging.appenders.stdout(
      'stdout',
      :layout => Logging.layouts.pattern(
        :pattern => '[%d] %-7l %c: %m\n',
        :color_scheme => 'soothing_ish'
      )
    )

    Logger = Logging.logger['multidapter']
    Logger.level = :info

    Logger.add_appenders \
      Logging.appenders.stdout,
      Logging.appenders.file('multidapter.log')
  end

  Kernel.const_set :Logger, Multidapter::Log::Logger
end
