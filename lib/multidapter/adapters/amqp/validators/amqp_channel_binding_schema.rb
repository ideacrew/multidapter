# frozen_string_literal: true

module Multidapter
  module Amqp
    module Validators
      ChannelBindingSchema = Dry::Schema.Params do

        required(:is).value(Types::Amqp::ChannelType)
        optional(:binding_version).maybe(:string)
        optional(:exchange).hash do 
          optional(:name).filled(:string)
          optional(:type).filled(Types::Amqp::ExchangeType)
          optional(:durable).maybe(:boolean)
          optional(:auto_delete).maybe(:boolean)
          optional(:vhost).maybe(Types::Amqp::Vhost)
        end
        optional(:queue).hash do 
          optional(:name).filled(:string)
          optional(:durable).maybe(:boolean)
          optional(:exclusive).maybe(:boolean)
          optional(:auto_delete).maybe(:boolean)
          optional(:vhost).maybe(Types::Amqp::Vhost)
        end



      end
    end
  end
end
