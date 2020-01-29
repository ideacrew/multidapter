# frozen_string_literal: true

module Multidapter
  module Adapters
    module Amqp
      module Operations
        class OpenChannel
        include Dry::Monads[:result, :do]

        def call(params)
          values  = yield validate(params)
          channel = yield open_channel(values)

          Success(channel)
        end

        def validate(params)
          # returns Success(values) or Failure(:invalid_data)
          contract = Multidapter::AsyncApi::Validators::ChannelContract.new
          Success(contract.call(params))
        end

        def open_channel(channel_values)
          # returns Success(channel) or Failure(:channel_not_created)
          channel = Multidapter::AsyncApi::Channel.new(channel_values.to_h)
          Success(channel)
        end
      end

      end
    end
  end
end


add_channel.rb