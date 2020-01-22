# frozen_string_literal: true

require_relative 'exchange'
require_relative 'queue'

module Multidapter
  module Adapters
    module Amqp
      class AmqpChannelBinding < Dry::Struct

        # Defines what type of channel is it. Can be either :queue or :routing_key (default).
        attribute :is,              Types::Amqp::ChannelTypes

        # The version of this binding. If omitted, "latest" MUST be assumed
        attribute :binding_version, Types::String

        # When is=routingKey, this object defines the exchange properties
        attribute :exchange do

          #   The name of the exchange. It MUST NOT exceed 255 characters long.
          attribute :name,        Types::String

          # The type of the exchange. Can be either topic, direct, fanout, default or headers.
          attribute :type,        Types::Amqp::ExchangeTypes

          # Whether the exchange should survive broker restarts or not.
          attribute :durable,     Types::Bool

          # Whether the exchange should be deleted when the last queue is unbound from it.
          attribute :auto_delete, Types::Bool

          # The virtual host of the exchange. Defaults to "/"
          attribute :vhost,       Types::String
        end

        # When is=queue, this object defines the queue properties
        attribute :queue do

          # The name of the  It MUST NOT exceed 255 characters long.
          attribute :name,        Types::String

          # Whether the queue should survive broker restarts or not.
          attribute :durable,     Types::Bool

          # Whether the queue should be used only by one connection or not.
          attribute :exclusive,   Types::Bool

          # Whether the queue should be deleted when the last consumer unsubscribes.
          attribute :auto_delete, Types::Bool

          # The virtual host of the queue. Defaults to /.
          attribute :vhost,       Types::String
        end
      end
    end
  end
end
