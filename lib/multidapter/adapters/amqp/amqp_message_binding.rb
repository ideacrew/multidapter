# frozen_string_literal: true

module Multidapter
  module AsyncApi
    class AmqpMessageBinding < Dry::Struct

        BINDING_OPTION_DEFAULTS = {
          is: nil,
          protocol: :amqp,
          binding_version: '0.2.0'.freeze,

          user_id: nil,       # Sender
          cc: ['user.logs'],            # message routing keys
          bcc: [],
          reply_to: 'user.signedup',      # name of queue where consumer should send response

          expiration: 100_000, # TTL
          priority: 10,
          delivery_mode: 1,   # 1 = transient, 2 = persistent
          timestamp: true,   # message should include timestamp

          # Producer only
          mandatory: false,    # message is required

          # Consumer only
          ack: false,
        }

      # A MIME encoding for the message content
      attribute :content_encoding, Type::String

      # Application-specific message type
      attribute :message_type, Type::String

      # The version of this binding. If omitted, "latest" MUST be assumed
      attribute :binding_version, Type::String

    end
  end
end
