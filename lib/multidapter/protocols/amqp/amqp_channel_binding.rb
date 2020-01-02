module Multidapter
  module AsyncApi
    class AmqpChannelBinding < Dry::Struct

      # Defines what type of channel is it. Can be either :queue or :routing_key (default).
      attribute :is,              Types::String

      # The version of this binding. If omitted, "latest" MUST be assumed
      attribute :binding_version, Types::String

      # When is=routingKey, this object defines the exchange properties
      attribute :exchange, Types::Hash.meta(omittable: true).default([]) do

        #   The name of the exchange. It MUST NOT exceed 255 characters long.
        attribute :name,        Types::String

        # The type of the exchange. Can be either topic, direct, fanout, default or headers.
        attribute :type,        Types::String

        # Whether the exchange should survive broker restarts or not.
        attribute :durable,     Types::Boolean

        # Whether the exchange should be deleted when the last queue is unbound from it.
        attribute :auto_delete, Types::Boolean

        # The virtual host of the exchange. Defaults to "/"
        attribute :vhost,       Types::String
      end

      # When is=queue, this object defines the queue properties
      attribute :queue, Types::Hash.meta(omittable: true).default([]) do

        # The name of the  It MUST NOT exceed 255 characters long.
        attribute :name,        Types::String

        # Whether the queue should survive broker restarts or not.
        attribute :durable,     Types::Boolean

        # Whether the queue should be used only by one connection or not.
        attribute :exclusive,   Types::Boolean

        # Whether the queue should be deleted when the last consumer unsubscribes.
        attribute :auto_delete, Types::Boolean

        # The virtual host of the queue. Defaults to /.
        attribute :vhost,       Types::String
      end
    end
  end
end
