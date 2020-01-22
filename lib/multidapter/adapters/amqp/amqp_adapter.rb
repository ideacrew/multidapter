# frozen_string_literal: true
require 'bunny'

require_relative 'amqp/uris/amqp_uri'
require_relative 'amqp/types'
require_relative 'amqp/validation/amqp_validation'

module Multidapter
  module Adapters
    class AmqpAdapter < Multidapter::Adapter

      OPTIONS_DEFAULT = {
        protocol:         :amqp,
        protocol_version: ->{ Bunny.protocol_version },
        host:             "127.0.0.1",
        port:             5672,

        vhost:            "/",
        user:             "guest",
        password:         "guest",

        channel_max:      2_047,
        heartbeat:        :server, # use the same value as RabbitMQ server

        ssl:                            false,
        auth_mechanism:                 "PLAIN",  # server authentication. "PLAIN" or EXTERNAL" suppoted

        network_recovery_interval:      5.0,      # reconnection interval for TCP conection failure
        automatic_recovery:             true,     # Bunny will try to recover from detected TCP connection failures every 5 seconds
        recover_from_connection_close:  true,     # Bunny will try to recover from Server-initiated connection.close
        continuation_timeout:           4_000,    # timeout in milliseconds for client operations that expect a response
        frame_max:                      131_072,  # max permissible size in bytes of a frame. Larger value may improve throughput; smaller value may improve latency
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

      # def self.call(uri, options = {})
      #   super
      # end




      def initialize(uri, options = {})
        super

        @uri = uri
        @options = OPTION_DEFAULTS.merge(options.merge(parse_uri(uri)))

        connection
        self
      end


      def connection
        @connection ||= Bunny.new(uri, @options)
      end

      def connect
        return if active?

        begin
          @connection.start
        rescue Bunny::TCPConnectionFailed => e
          raise Multidapter::Error::ConnectionError, "Connection failed to: #{uri}"
        rescue Bunny::PossibleAuthenticationFailureError => e
          raise Multidapter::Error::AuthenticationError, "Likely athentication failure for account: #{@connection.user}"
        ensure
          connection.close if connection
        end

        sleep 1.0

        # logger "#{name} connection active"
        on_connect if active?

        active?
      end

      def on_connect
      end

      def test_connection
        super
      end

      # Use Bunny automatic recovery feature (when :recover_from_connection_close => true)
      # Feature handles the following:
      # Re-open channels
      # For each channel, re-declare exchanges (except for predefined ones)
      # For each channel, re-declare queues
      # For each queue, recover all bindings
      # For each queue, recover all consumers
      def reconnect
      end

      def close
        return unless active?
        close!
      end

      def close!
        connection.close if connection
      end

      def active?
        @connection && @connection.open?
      end

      def connection_status
        @connection.status
      end

      private

      def parse_uri(uri)
        AMQ::Settings.configure(uri)
      end


    end
  end
end
