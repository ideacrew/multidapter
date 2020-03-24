# frozen_string_literal: true
require_relative 'bunny_client'

# Adapt Bunny client to common Multidapter::Adapters::Adapter interface (via Multidapter::Adapters::Amqp::AmqpAdapter)

module Multidapter
  module Adapters
    module Amqp
      class AmqpBunnyAdapter < Multidapter::Adapters::Adapter

        CLIENT_CLASS_NAME = "Multidapter::Adapters::Amqp::BunnyClient"

        attr_reader :connection_bindings, :security_scheme, :connection

        def self.call(server, options = {})
          adapter = new(server, options = {})
          adapter.connect
          adapter
        end

        # Merge Bunny default bindings with passed overrides != nil.  Use the options hash for any key that should
        # be forced to nil
        def initialize(server, options = {})
          raise ArgumentError unless server.is_a? Multidapter::Server

          @server = server.to_h
          @bunny_client_klass = Object.const_get(CLIENT_CLASS_NAME)

          combined_bindings = merge_bindings
          @connection_bindings = combined_bindings.merge(options)

          @bunny_client = @bunny_client_klass.new(@connection_bindings)
          @connection = connection
          self
        end

        # Represents AMQP 0.9.1 connection to a RabbitMQ node
        def connection
          @connection ||= @bunny_client.session
        end

        def connect
          @connection.start unless active?
        end

        def name
          Multidapter::Adapters::Amqp::PROTOCOL
        end

        def reconnect!
          @connection.reconnect!
        end

        def close
          close! if active?
        end

        def close!
          @connection.close if connection
        end

        def active?
          @connection && @connection.open?
        end

        def connection_status
          @connection.status
        end

        def version
          @bunny_client_klass::VERSION if defined? @bunny_client_klass
        end

        def protocol_version
          @bunny_client_klass::PROTOCOL_VERSION if defined? @bunny_client_klass
        end

        private

        def parse_uri(uri)
          AMQ::Settings.configure(uri)
        end

        private

        # Merge Client Class default bindings with passed-in override settings where
        # values != nil
        def merge_bindings
          client_bindings_default = @bunny_client_klass::BINDINGS_DEFAULT
          input_bindings = parse_connection_bindings(@server)

          client_bindings_default.merge(input_bindings){ |key, oldval, newval| newval || oldval }
        end

        # Map the AsyncAPI Server Object to client API values
        def parse_connection_bindings(bindings)
          @connection_bindings ||= parse_adapter_protocol_connection(bindings)
        end

        def parse_adapter_protocol_connection(bindings)
          parse_security_scheme(bindings)

          connection_map = {
            host:           parse_uri(bindings.dig(:url)),
            port:           bindings.dig(:variables, :port, :default),
            vhost:          bindings.dig(:variables, :vhost, :default),
            username:       bindings.dig(:variables, :user, :default),
            password:       bindings.dig(:variables, :password, :default),
            tls:            bindings.dig(:variables, :ssl, :default),
            heartbeat:      bindings.dig(:variables, :heartbeat, :default),
            frame_max:      bindings.dig(:variables, :frame_max, :default),
          }

          connection_map.merge(@security_scheme)
        end

        def parse_security_scheme(bindings)
          @security_scheme ||= parse_adapter_protocol_security(bindings)
        end

        def parse_adapter_protocol_security(bindings)
          security_type = bindings.dig(:security, :type)
          return {} unless security_type

          case security_type
          when :user_password
            Hash.new(
              auth_mechanism: 'PLAIN',
              username: bindings.dig(:variables, :user, :default),
              password: bindings.dig(:variables, :password, :default),
              tls:      false,
            )
          else
            raise Multidapter::Errors::AmqpAdapterSecurityError, "security: #{security_type} not supported"
          end
        end

      end
    end
  end
end
