# frozen_string_literal: true

module Multidapter
  module Adapters
    module Amqp
      module Validators

        ExchangeHashSchema = Dry::Schema.Params do
          optional(:name).filled(:string)
          optional(:type).maybe(Types::Amqp::ExchangeTypes)
          optional(:durable).maybe(:bool)
          optional(:auto_delete).maybe(:bool)
          optional(:vhost).maybe(:string)
        end

        QueueHashSchema = Dry::Schema.Params do
          optional(:name).filled(:string)
          optional(:durable).maybe(:bool)
          optional(:exclusive).maybe(:bool)
          optional(:auto_delete).maybe(:bool)
          optional(:vhost).maybe(:string)
        end

        class AmqpChannelBindingContract < Dry::Validation::Contract

          params do
            required(:is).value(Types::Amqp::ChannelTypes)
            optional(:binding_version).maybe(:string)
            optional(:exchange).maybe(Multidapter::Adapters::Amqp::Validators::ExchangeHashSchema)
            optional(:queue).maybe(Multidapter::Adapters::Amqp::Validators::QueueHashSchema)
          end

        end
      end
    end
  end
end
