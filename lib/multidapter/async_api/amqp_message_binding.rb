# frozen_string_literal: true

module Multidapter
  module AsyncApi
    class AmqpMessageBinding < Dry::Struct

      # A MIME encoding for the message content
      attribute :content_encoding, Type::String

      # Application-specific message type
      attribute :message_type, Type::String

      # The version of this binding. If omitted, "latest" MUST be assumed
      attribute :binding_version, Type::String

    end
  end
end
