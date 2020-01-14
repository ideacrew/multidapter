# frozen_string_literal: true

module Multidapter
  module Adapters
    module Amqp
      module Validations

        OperationBindingSchema = Dry::Schema.Params do

          optional(:expiration).value(Types::PositiveInteger)
          optional(:user_id).maybe(:string)
          optional(:cc).maybe(Types::Amqp::RoutingKeys)
          optional(:priority).maybe(:integer)
          optional(:delivery_mode).maybe(Types::Amqp::MessageDeliveryMode)
          optional(:mandatory).maybe(:bool)
          optional(:bcc).maybe(Types::Amqp::RoutingKeys)
          optional(:reply_to).maybe(Types::Amqp::QueueName)
          optional(:timestamp).maybe(:bool)
          optional(:ack).maybe(:bool)
          optional(:binding_version).maybe(:string)

        end
      end
    end
  end
end
