# frozen_string_literal: true

module Multidapter
  module Adapters
    module Amqp
      module Validators
        
        ChannelBindingSchema = Dry::Schema.JSON do

          required(:is).value(Types::Amqp::ChannelTypes)
          optional(:binding_version).maybe(:string)
          optional(:exchange).hash do
            optional(:name).filled(:string)
            optional(:type).filled(Types::Amqp::ExchangeTypes)
            optional(:durable).maybe(:bool)
            optional(:auto_delete).maybe(:bool)
            optional(:vhost).maybe(:string)
          end
          optional(:queue).hash do
            optional(:name).filled(:string)
            optional(:durable).maybe(:bool)
            optional(:exclusive).maybe(:bool)
            optional(:auto_delete).maybe(:bool)
            optional(:vhost).maybe(:string)
          end


        end
      end
    end
  end
end
