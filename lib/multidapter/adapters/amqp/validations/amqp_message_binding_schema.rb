# frozen_string_literal: true


module Multidapter
  module Adapters
    module Amqp
      module Validations
        
        AmqpMessageBindingSchema = Dry::Schema.Params do
          # MIME encoding for the message content.
          optional(:content_encoding).maybe(:string)

          # Application-specific message type
          optional(:message_type).maybe(:string)

          # The version of this binding. If omitted, "latest" MUST be assumed
          optional(:binding_version).maybe(:string).default("0.2.0")
        end
      end
    end
  end
end
