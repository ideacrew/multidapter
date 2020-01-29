# frozen_string_literal: true
require 'bunny'

module Multidapter
  module Adapters
    module Amqp
      module Operations
        class ConnectServer
          include Dry::Monads[:result, :do]

          # Defaults for Bunny client connection. May be overriden with Options hash
          OPTIONS_DEFAULT = {
            protocol:         :amqp,
            # protocol_version: ->{ Bunny.protocol_version },
            host:             "127.0.0.1",
            port:             5672,
            vhost:            "/",
            channel_max:      2_047,
            heartbeat:        :server, # use the same value as RabbitMQ server

            user:             "guest",
            password:         "guest",
            ssl:                            false,
            auth_mechanism:                 "PLAIN",  # server authentication. "PLAIN" or EXTERNAL" suppoted

            network_recovery_interval:      5.0,      # reconnection interval for TCP conection failure
            automatic_recovery:             true,     # Bunny will try to recover from detected TCP connection failures every 5 seconds
            recover_from_connection_close:  true,     # Bunny will try to recover from Server-initiated connection.close
            continuation_timeout:           4_000,    # timeout in milliseconds for client operations that expect a response
            frame_max:                      131_072,  # max permissible size in bytes of a frame. Larger value may improve throughput; smaller value may improve latency
          }.freeze

          PROTOCOL_DEFAULTS = {
            heartbeat:  :server, # will use RabbitMQ setting
            frame_max:  131072,
          }.freeze


          def map_server_security_to_bunny(server)

          end


          def call(params)
            server      = yield create_server(params)
            options_hash = yield extract_server_variables(server)

            connection  = yield open_connection(server)
            connect     = yield connect_server(connection)

            Success(connection)
          end

          private

          def extract_server_variables(server)
            # return {} if server == nil
            variables_array = server.to_h.fetch(:variables, [])
            options = map_variables_to_hash(variables_array)
            Success(options)
          end

          def map_variables_to_hash(variables_array)
            variables_array.reduce({}) do |map, var|
              map.merge!({ var[:key] => var[:value][:default] })
            end
          end

          def merge_options(values)
            # binding.pry
            server_options = map_variables_to_options(values.to_h[:variables])
            OPTIONS_DEFAULT.merge(server_options)
          end
          def create_server(params)
            Success(Multidapter::AsyncApi::Operations::CreateServer.call(params))
          end

          def open_connection(server)
            # returns Success(values) or Failure(:server_not_created)
            # binding.pry
            options = { }
            url = server.value!.url.to_s

            Success(Bunny.new(url, options))
          end

          def connect_server(connection)
            # returns Success(channel) or Failure(:channel_not_created)
            begin
              connection.start
            rescue Bunny::TCPConnectionFailed => e
              raise Multidapter::Error::ConnectionError, "Connection failed to: #{connection.uri}"
            rescue Bunny::PossibleAuthenticationFailureError => e
              raise Multidapter::Error::AuthenticationError, "Likely athentication failure for account: #{connection.user}"
            ensure
              connection.close if connection
            end

            Success(connection && connection.open?)
          end
        end

      end
    end
  end
end
