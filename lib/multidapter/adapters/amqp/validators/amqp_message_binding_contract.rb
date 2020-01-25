# frozen_string_literal: true

require 'mime/types'

module Multidapter
  module Adapters
    module Amqp
      module Validators
        class AmqpMessageBindingContract < Dry::Validation::Contract

          params do
            optional(:content_encoding).maybe(:string)
            optional(:message_type).maybe(:string)
            optional(:binding_version).maybe(:string)
          end

          rule(:content_encoding) do
            key.failure("unknown Mime type: #{value}") unless ::MIME::Types[value].size > 0
          end


        end
      end
    end
  end
end
