# frozen_string_literal: true

# The Adapter class defines the common interface that all adapters must support
# 

module Multidapter
  module Adapters
    class Adapter

      def self.call(uri, options = {})
        new(uri, options).connection
      end

      attr_reader :uri, :protocol, :protocol_versions, :connection

      def initialize(server, options = {})
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

      def test_conection
      end

      class << self
        def add_server(new_server)
          @servers << new_server
        end

        def servers
          @servers
        end

        def add_adapter(new_adapter)
          @adapters << new_adapter
        end

        def adapters
          @adapters
        end
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
