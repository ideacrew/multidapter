# frozen_string_literal: true

module Multidapter
  module Validators

    # Schema and validation rules for {Multidapter::Channel}
    class ChannelContract < Contract

      # @!method call(opts)
      # @param [Hash] opts the parameters to validate using this contract
      # @option opts [Symbol] :channel_id required
      # @option opts [ChannelItem] :channel_item optional
      # @return [Dry::Monads::Result::Success, Dry::Monads::Result::Failure]
      params do
        required(:channel_id).value(:symbol)
        # optional(:channel_item).maybe(Multidapter::Channel)
        optional(:channel_item).maybe(:hash)
      end

    end
  end
end
