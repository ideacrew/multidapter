# frozen_string_literal: true

module Multidapter
  module Adapters
    module Amqp
      class AmqpOperationBinding < Dry::Struct

        # Publish, Subscribe  TTL (Time-To-Live) for the message. It MUST be greater than or equal to zero
        attribute :expiration,      Types::PositiveInteger

        # Publish, Subscribe  Identifies the user who has sent the message
        attribute :user_id,         Types::String

        # Publish, Subscribe  The routing keys the message should be routed to at the time of publishing
        attribute :cc,              Types::Amqp::RoutingKeys

        # Publish, Subscribe  A priority for the message
        attribute :priority,        Types::Integer

        # Publish, Subscribe  Delivery mode of the message. Its value MUST be either 1 (transient) or 2 (persistent)
        attribute :delivery_mode,   Types::Amqp::MessageDeliveryMode

        # Publish Whether the message is mandatory or not
        attribute :mandatory,       Types::Bool

        # Publish, Like cc but consumers will not receive this information
        attribute :bcc,             Types::Amqp::RoutingKeys

        # Publish, Subscribe  Name of the queue where the consumer should send the response
        attribute :reply_to,        Types::Amqp::QueueName

        # Publish, Subscribe  Whether the message should include a timestamp or not
        attribute :timestamp,       Types::Bool

        # Subscribe Whether the consumer should ack the message or not
        attribute :ack,             Types::Bool

        # Publish, Subscribe  The version of this binding. If omitted, "latest" MUST be assumed
        attribute :binding_version, Types::String


      end
    end
  end
end
