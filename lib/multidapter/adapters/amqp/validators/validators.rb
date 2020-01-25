# frozen_string_literal: true

require_relative "amqp_channel_binding_contract"
require_relative "amqp_operation_binding_contract"
require_relative "amqp_message_binding_contract"

module Multidapter
  module Adapters
    module Amqp
      module Validators
        class AmqpContract < Dry::Validation::Contract

        end
      end
    end
  end
end
