# frozen_string_literal: true

# The Connection class defines the common interface that all connections must support
# 

module Multidapter
  module Adapters
    class Connection

      def add_channel
      end

      def channels
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

      def test
      end


    end
  end
end