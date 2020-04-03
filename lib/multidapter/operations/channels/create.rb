# frozen_string_literal: true

module Multidapter
  module Operations
    module Channels

      # Create a {Channel} instance
      class Create
        send(:include, Dry::Monads[:result, :do])

        # @param [Hash] params Values to use to create the Channel instance. Validated using {Validators::ChannelContract ChannelContract}
        # @example
        #  { channel_id: "user_enrollments" channel_item: { subscribe: { summary: 'A customer enrolled' } } }
        # @return [Dry::Monads::Result::Success<Channel>] if Channel is created
        # @return [Dry::Monads::Result::Failure<Hash>] if Channel creation fails
        def call(params)
          values = yield validate(params)
          entity = yield create(values)

          Success(entity)
        end

        private

        def validate(params)
          result = Multidapter::Validators::ChannelContract.new.call(params)
          result.success? ? Success(result) : Failure(result)
        end

        def create(values)
          result = Multidapter::Channel.call(values.to_h)
          Success(result)
        end

      end

    end
  end
end
