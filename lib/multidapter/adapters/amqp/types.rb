# frozen_string_literal: true

module Types
  module Amqp

      Vhost               = ::Types::Coercible::String.default("/")
      ChannelTypes        = ::Types::Coercible::Symbol.default(:routing_key).enum(:routing_key, :queue)
      ExchangeTypes       = ::Types::Coercible::Symbol.enum(:topic, :fanout, :default, :direct, :headers)
      MessageDeliveryMode = ::Types::Coercible::Integer.enum(1, 2)
      RoutingKey          = ::Types::Coercible::String
      RoutingKeys         = ::Types::Array.of(RoutingKey)
      QueueName           = ::Types::Coercible::String

  # PatternedFieldName  = String.constrained(format: /^[A-Za-z0-9_\-]+$/)

  end
end
