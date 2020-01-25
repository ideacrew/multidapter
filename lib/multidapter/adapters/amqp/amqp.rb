# frozen_string_literal: true

require_relative 'uris/amqp_uri'
require_relative 'errors'
require_relative 'types'
require_relative 'validators/validators'
require_relative 'amqp_bunny_adapter'
require_relative 'operations/operation'
require_relative 'amqp_message_binding'
require_relative 'amqp_operation_binding'
require_relative 'amqp_channel_binding'

# Create a level of indirection for AMQP to support multiple clients, namely
# Bunny and Sneakers

module Multidapter
  module Adapters 
    module Amqp

      PROTOCOL    = :amqp
      DESCRIPTION = 'RabbitMQ Server'

      # support Bunny and Sneakers adapters for AMQP
      def clients
        @adapters ||= {
          bunny:    Multidapter::Adapters::Amqp::AmqpBunnyAdapter,
          sneakers: Multidapter::Adapters::Amqp::AmqpSneakersAdapter,
        }
      end

      def add_client(key, client)
        raise Multidapter::Errors::DuplicateClientError("#{key} client already exists") if clients.include?(key)
        clients.merge!(name.to_sym => client)
      end

      def build(client, server, options = {})
        client_klass = clients[client]
        client_klass.new(server, options)
      end

    end
  end
end
