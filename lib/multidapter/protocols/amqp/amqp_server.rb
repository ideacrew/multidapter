
module Multidapter
  module Adapters
    class AmqpServer < Multidapter::Server

      ENDPOINT_DEFAULTS = {
        host:         "127.0.0.1",
        port:         5672,
        vhost:        "/",
        user:         "guest",
        password:     "guest",

        channel_max:  2_047,
        heartbeat:    :server, # use the same value as RabbitMQ server

        ssl:        false,
        auth_mechanism: "PLAIN",

        network_recovery_interval:  5.0 # reconnection interval for TCP conection failure
      }

      PROTOCOL_DEFAULTS = {
        heartbeat:  :server, # will use RabbitMQ setting
        frame_max:  131072,
      }

      OPTION_DEFAULTS = {
        protocol:             :amqp,
        protocol_version:     "1.9.1",
        default_content_type: 'application/json',
        description: 'RabbitMQ Server',
      }

      def initialize(endpoint, options = {})
        @options = OPTION_DEFAULTS.merge(options)
        super

        @host = options[:host]

        @default_content_type = options[:default_content_type]
        @channels = []
      end

      def connection
        @connection ||= Bunny.new("amqp://guest:guest@vm188.dev.megacorp.com/profitd.qa")

        # Bunny::PossibleAuthenticationFailureException
        # Bunny::TCPConnectionFailed
        # Bunny::NetworkFailure
      end

      def connect
        begin
          @connection.start
        rescue Bunny::TCPConnectionFailed => e
          puts "Connection to #{@connection} failed"
        end
      end

      def close
        @connection.close
      end

    end
  end
end
