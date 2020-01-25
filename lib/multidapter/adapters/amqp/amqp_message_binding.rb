# frozen_string_literal: true

module Multidapter
  module Adapters
    module Amqp
      class AmqpMessageBinding < Dry::Struct

          # A MIME encoding for the message content
          attribute :content_encoding, Types::String

          # Application-specific message type
          attribute :message_type, Types::String

          # The version of this binding. If omitted, "latest" MUST be assumed
          attribute :binding_version, Types::String

      end
    end
  end
end
