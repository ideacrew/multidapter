# frozen_string_literal: true

module Multidapter
  module Adapters
    module Amqp
      class Exchange < Dry::Struct

          #   The name of the exchange. It MUST NOT exceed 255 characters long.
          attribute :name,        Types::Coercible::String

          # The type of the exchange. Can be either topic, direct, fanout, default or headers.
          attribute :type,        Types::Amqp::ExchangeTypes

          # Whether the exchange should survive broker restarts or not.
          attribute :durable,     Types::Bool

          # Whether the exchange should be deleted when the last queue is unbound from it.
          attribute :auto_delete, Types::Bool

          # The virtual host of the exchange. Defaults to "/"
          attribute :vhost,       Types::Coercible::String

      end
    end
  end
end
