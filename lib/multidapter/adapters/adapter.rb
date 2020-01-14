# frozen_string_literal: true

module Multidapter
  module Adapters
    class Adapter

      def self.call(uri, options = {})
        new(uri, options).connection
      end

      attr_reader :uri, :protocol, :protcol_versions, :options

      def initialize(uri, options = {})
        @connection       = nil
        @active           = false

        @servers          = []
        @channels         = []
        @components       = []
        @tags             = []
        @external_docs    = []

        @options = OPTION_DEFAULTS.merge(options)
      end

      def name
        @options[:protocol].to_s
      end

      def connection
      end

      def connect
        begin
          if block.given?
            yield(server_connection)
          else
            server_connection
          end
        ensure
          if block.given?
            server_connection.close if server_connection
          end
        end
      end

      def on_connect
      end

      def active?
      end

      def close
      end

      # Disconnects from server if already connected and establishes a new connection to server
      def reconnect
      end


      def self.add_server(new_server)
        @servers << new_server
      end

      def self.servers
        @servers
      end

      def self.add_adapter(new_adapter)
        @adapters << new_adapter
      end

      def self.adapters
        @adapters
      end


      def logger(msg)
        @debug_output << msg + "\n" if @debug_output
      end

      def test_connection
        return true if active?

        begin
          connect
          if @active
            logger "#{name} connection test succeeded"
            true
          end
        ensure
          close
        end
      end


      private

      def log
      end

    end
  end
end
