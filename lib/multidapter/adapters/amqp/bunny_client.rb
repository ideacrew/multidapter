# frozen_string_literal: true
require 'bunny'


module Multidapter
  module Adapters
    module Amqp
      class BunnyClient

        VERSION = Bunny.version
        PROTOCOL_VERSION = Bunny.protocol_version

        BINDINGS_DEFAULT = {
          host:                                         "127.0.0.1",
          port:                                         15672,    # (Integer) — default: 5672 — Port RabbitMQ listens on
          tls:                                          false,
          username:                                     'guest',
          password:                                     'guest',
          vhost:                                        '/',      # (String) — default: "/" — Virtual host to use
          # RabbitMQ URI Query params
          heartbeat:                                    :server,  # (Integer, Symbol) — default: :server — Heartbeat timeout to offer to the server. :server means use the value suggested by RabbitMQ. 0 means heartbeats and socket read timeouts will be disabled (not recommended)
          continuation_timeout:                         15_000,   # timeout in milliseconds for client operations that expect a response
          network_recovery_interval:                    5.0,      # reconnection interval for TCP conection failure
          channel_max:                                  2_047,    # Maximum number of channels allowed on this connection, minus 1 to account for the special channel 0
          connection_timeout:                           4_000,    # timeout in milliseconds for client operations that expect a response

          read_timeout:                                 30,     # (Integer) — default: 30 — TCP socket read timeout in seconds. If heartbeats are disabled this will be ignored.
          write_timeout:                                30,      # (Integer) — default: 30 — TCP socket write timeout in seconds.
          recovery_completed:                           nil, # (Proc) — a callable that will be called when a network recovery is performed
          logger:                                       nil, # (Logger) — The logger. If missing, one is created using :log_file and :log_level.
          log_file:                                     nil, # (IO, String) — The file or path to use when creating a logger. Defaults to STDOUT.
          log_level:                                    nil, # (Integer) — The log level to use when creating a logger. Defaults to LOGGER::WARN
          recovery_attempts:                            nil, # (Integer) — default: nil — Max number of recovery attempts, nil means forever
          reset_recovery_attempts_after_reconnection:   true, # (Integer) — default: true — Should recovery attempt counter be reset after successful reconnection? When set to false, the attempt counter will last through the entire lifetime of the connection object.
          recover_from_connection_close:                true, # (Boolean) — default: true — Should this connection recover after receiving a server-sent connection.close (e.g. connection was force closed)?
        }.freeze

        MULTI_HOSTS_BINDINGS_DEFAULT = {
          hosts:                                        [], # (Array<String>) — default: ["127.0.0.1"] — list of hostname or IP addresses to select hostname from when connecting
          addresses:                                    [], # (Array<String>) — default: ["127.0.0.1:5672"] — list of addresses to select hostname and port from when connecting
          hosts_shuffle_strategy:                       nil, # (Proc) — a callable that reorders a list of host strings, defaults to Array#shuffle
        }

        SECURITY_OPTIONS_DEFAULT = {
          ssl:        false,
          username:   "guest",
          password:   "guest",
        }

        TLS_SECURITY_BINDINGS = {
          tls:                      false,        # (Boolean) — default: false — Should TLS/SSL be used?
          tls_cert:                 nil,          # (String) — default: nil — Path to client TLS/SSL certificate file (.pem)
          tls_key:                  nil,          # (String) — default: nil — Path to client TLS/SSL private key file (.pem)
          tls_ca_certificates:      [],           # (Array<String>) — Array of paths to TLS/SSL CA files (.pem), by default detected from OpenSSL configuration
          verify_peer:              true,         # (String) — default: true — Whether TLS peer verification should be performed
          tls_version:              :negotiated,  # (Symbol) — default: negotiated — What TLS version should be used (:TLSv1, :TLSv1_1, or :TLSv1_2)
        }

        OPZ_DEFAULT = {
          auth_mechanism:           'PLAIN',  # server authentication. "PLAIN" or EXTERNAL" suppoted
          locale:                   'PLAIN', # (String) — default: "PLAIN" — Locale RabbitMQ should use
        }

        # Use Bunny automatic recovery feature (when :recover_from_connection_close => true)
        # Feature handles the following:
        # Re-open channels
        # For each channel, re-declare exchanges (except for predefined ones)
        # For each channel, re-declare queues
        # For each queue, recover all bindings
        # For each queue, recover all consumers

        attr_reader :session

        def self.call(connection_string)
          id = 'multidapter'
          new(id, connection_string).session
        end

        def initialize(app_id = 'multidapter', connection_string = {})
          @app_id = app_id
          @connection_string = connection_string
        end

        def open_connection_if_needed
          if !@connection
            @connection = Bunny.new
            @connection.start

            # @channel = @connection.create_channel
            # @queue = @channel.queue(QUEUE_NAME, {:durable => true})
            # @exchange = @channel.fanout(EXCHANGE_NAME, {:durable => true})
            # @queue.bind(@exchange, {})
          end
        end

        def session
          @session ||= Bunny.new(@connection_string)
        end

        def start
          return if @session.open?

          begin
            @session.start
          rescue Bunny::TCPConnectionFailed => e
            raise Multidapter::Error::ConnectionError, "Connection failed to: #{@session.host}"
          rescue Bunny::PossibleAuthenticationFailureError => e
            raise Multidapter::Error::AuthenticationError, "Likely authentication failure for account: #{@session.username}"
          ensure
            session.close if session
          end

          @session
        end

        def open?
          @session.open?
        end

        def reconnect!
          @session.disconnect!
        end

        def disconnect!
          if @session
            begin
              @session.close
            rescue Timeout::Error
            end
            @session = nil
          end
        end

        def self.boot!(app_id)
          @@instance = self.new(app_id)
        end

        def self.instance
          @@instance
        end

        def self.reconnect!
          instance.reconnect!
        end

        def self.log(name, started, finished, unique_id, data)
          instance.log(name, started, finished, unique_id, data)
        end

        def self.logging!
          if defined?(@@instance) && !@instance.nil?
            @@instance.disconnect!
          end
          @@instance = LoggingPublisher.new
        end

        def self.disable!
          if defined?(@@instance) && !@instance.nil?
            @@instance.disconnect!
          end
          @@instance = DoNothingPublisher.new
        end

        private

        def log(name, started, finished, unique_id, data = {})
          open_connection_if_needed
          if data.has_key?(:x_no_rebroadcast) || data.has_key?("x_no_rebroadcast")
            return
          end
          msg = Acapi::Amqp::OutMessage.new(@app_id, name, finished, finished, unique_id, data)
          @exchange.publish(*msg.to_message_properties)
        end

      end
    end
  end
end
