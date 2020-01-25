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
        attribute :binding_version, Types::Coercible::String

        # When is=routingKey, this object defines the exchange properties
        attribute :exchange,        Multidapter::Adapters::Amqp::Exchange.meta(omittable: true)

        # When is=queue, this object defines the queue properties
        attribute :queue,           Multidapter::Adapters::Amqp::Queue.meta(omittable: true)
      end
    end
  end
end
