# frozen_string_literal: true

module Multidapter
  module Adapters
    module Amqp
      module Operations

        # Construct a Bunny client AMQP Server object from an AsyncAPI Server object.
        # The Bunny client includes RabbitMQ configuration extensions to the AysncAPI specification.
        # The AMQP Server provides support for these configuration options by mapping them to
        # values on AsyncAPI Server object's Variables attribute. These configuration settings match the
        # Bunnie client's default settings for each value

        class CreateServer
          include Dry::Monads[:result, :do]

          {
            url: [ :host, :port, :vhost ],
            host: :url,


          }

          def variables_defaults
            [
              { key: :ssl, value: { default: "false" } },
              { key: :port, value: { default: "5672" } },
              { key: :vhost, value: { default: "/" } },

              { key: :auth_mechanism, value: { default: "PLAIN", description: "Clear text password" } },
              { key: :user, value: { default: "guest", description: "Clear text user name" } },
              { key: :password, value: { default: "guest", description: "Clear text password" } },

              { key: :channel_max, value: { default: "2_047", description: "" } },
              { key: :heartbeat, value: { default: "server", description: "Use the same value as RabbitMQ server" } },

              { key: :network_recovery_interval, value: { default: "5.0", description: "Reconnection interval for TCP conection failure" } },
              { key: :automatic_recovery, value: { default: "true", description: "Bunny will try to recover from detected TCP connection failures every 5 seconds" } },
              { key: :recover_from_connection_close, value: { default: "true", description: "Bunny will try to recover from Server-initiated connection.close" } },
              { key: :continuation_timeout, value: { default: "4000", description: "Timeout in milliseconds for client operations that expect a response" } },
              { key: :frame_max, value: { default: "131072", description: "Max permissible size in bytes of a frame. Larger value may improve throughput; smaller value may improve latency" } },
            ]
          end

          # Defaults for Bunny client connection. Values are overriden by [Multidapter::AsyncAPI::Server]
          BUNNY_OPTIONS_DEFAULT = {
            host:                           { default: "127.0.0.1", description: "" },
            port:                           5672,
            vhost:                          "/",

            channel_max:                    2_047,
            heartbeat:                      { default: "server", description: "Use the same value as RabbitMQ server" },

            auth_mechanism:                 "PLAIN",  # server authentication. "PLAIN" or EXTERNAL" suppoted
            user:                           "guest",
            password:                       "guest",
            ssl:                            false,

            network_recovery_interval:      5.0,      # reconnection interval for TCP conection failure
            automatic_recovery:             true,     # Bunny will try to recover from detected TCP connection failures every 5 seconds
            recover_from_connection_close:  true,     # Bunny will try to recover from Server-initiated connection.close
            continuation_timeout:           4_000,    # timeout in milliseconds for client operations that expect a response
            frame_max:                      131_072,  # max permissible size in bytes of a frame. Larger value may improve throughput; smaller value may improve latency
          }.freeze


          BUNNY_SERVER_OPTIONS_DEFAULT = {
            url:              "amqp://127.0.0.1:5672",
            protocol:         :amqp,
            protocol_version: "1.9.1",
            description: 'RabbitMQ Server',
          }.freeze

          BUNNY_SECURITY_OPTIONS_DEFAULT = {
            url:              "amqp://127.0.0.1:5672",
            protocol:         :amqp,
            protocol_version: "1.9.1",
            description: 'RabbitMQ Server',
          }.freeze

          # Constructor method for AMQP Adapter Server object
          #
          # @param [Multidapter::AsyncApi::Server]
          # @return [Multidapter::Adapters::AmqpAdapter]
          def call(params)
            values = yield merge_defaults(params)
            @server = yield create_server(values)

            Success(server)
          end

          private

          def merge_defaults(params)
            server_defaults = {

            }.freeze

            server_defaults.merge(params)
          end

          def map_security_config(server)
            return unless server[:security] && server[:security][:type]

            security_scheme = server[:security]

            case security_scheme[:type]
            when :user_password
              { auth_mechanism: "PLAIN" }
            else
              # logger("encountered unsupported security scheme: #{security_scheme[:type]}")
              {}
            end
          end

          def fetch_server_variable(variable)
            @server[:variables].detect { |var| var[:key] == variable }
          end

          def map_host(server)
            # parse the URI and merge with host attributes
          end

          def server_defaults

          end





          def map_setting_to_variable(setting_hash)

          end


          def security_defaults
            {
              type: :user_password,
              description: "Clear text user name and password.  Find values in Variables attribute."
            }.freeze
          end

          def create_server(values)
            Multidapter::AsyncApi::Operations::CreateServer.call(values)
          end
        end

      end
    end
  end
end
