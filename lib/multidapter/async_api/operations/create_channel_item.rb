module Multidapter
  module AsyncApi
    module Operations
      class CreateChannelItem
        include Dry::Monads[:result, :do]

        def call(params)
          values  = yield validate(params)
          channel = yield create_channel_item(values)

          Success(channel)
        end

        def validate(params)
          # returns Success(values) or Failure(:invalid_data)
          contract = Multidapter::AsyncApi::Validators::ChannelItemContract.new
          Success(contract.call(params))
        end

        def create_channel_item(channel_values)
          # returns Success(channel) or Failure(:channel_not_created)
          channel = Multidapter::AsyncApi::ChannelItem.new(channel_values.values.to_h)
          Success(channel)
        end
      end
    end
  end
end
