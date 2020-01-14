# frozen_string_literal: true

module Multidapter
  module Adapters
    module Amqp
      module Validations
        
        ChannelBindingSchema = Dry::Schema.Params do

          required(:is).value(Types::Amqp::ChannelType)
          optional(:binding_version).maybe(:string)
          optional(:exchange).hash do
            optional(:name).filled(:string)
            optional(:type).filled(Types::Amqp::ExchangeType)
            optional(:durable).maybe(:bool)
            optional(:auto_delete).maybe(:bool)
            optional(:vhost).maybe(Types::Amqp::Vhost)
          end
          optional(:queue).hash do
            optional(:name).filled(:string)
            optional(:durable).maybe(:bool)
            optional(:exclusive).maybe(:bool)
            optional(:auto_delete).maybe(:bool)
            optional(:vhost).maybe(Types::Amqp::Vhost)
          end


        end
      end
    end
  end
end
