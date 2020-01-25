# frozen_string_literal: true

module Multidapter
  module AsyncApi
    module Operations
      class CreateChannel
        include Dry::Monads[:result, :do]

        def call(params)
          values  = yield validate(params)
          channel = yield create_channel(values)

          Success(channel)
        end

        def validate(params)
          # returns Success(values) or Failure(:invalid_data)
          contract = Multidapter::AsyncApi::Validators::ChannelContract.new
          Success(contract.call(params))
        end

        def create_channel(channel_values)
          # returns Success(channel) or Failure(:channel_not_created)
          channel = Multidapter::AsyncApi::Channel.new(channel_values.to_h)
          Success(channel)
        end
      end
    end
  end
end
