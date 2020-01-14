# frozen_string_literal: true

module Types
  module Amqp

      Vhost               = ::Types::Coercible::String.default("/")
      ChannelType         = ::Types::Coercible::Symbol.default(:routing_key).enum(:routing_key, :queue)
      ExchangeType        = ::Types::Coercible::Symbol.enum(:topic, :fanout, :default, :direct, :headers)
      MessageDeliveryMode = ::Types::Coercible::Integer.enum(1, 2)
      RoutingKey          = ::Types::Coercible::String
      RoutingKeys         = ::Types::Array.of(RoutingKey)
      QueueName           = ::Types::Coercible::String

  end
end
