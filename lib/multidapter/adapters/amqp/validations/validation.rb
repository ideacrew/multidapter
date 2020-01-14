# frozen_string_literal: true

require_relative "amqp_channel_binding_schema"
require_relative "amqp_operation_binding_schema"
require_relative "amqp_operation_binding_schema"

module Multidapter
  module Adapters
    module Amqp
      module Validation
        class AmqpContract < Dry::Validation::Contract

        end
      end
    end
  end
end
