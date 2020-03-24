# frozen_string_literal: true

module Multidapter
  module Validators

    # Schema and validation rules for {Multidapter::Channel}
    class ChannelContract < Dry::Validation::Contract

      # @!method call(Hash)
      #   @param [String] channel_id (optional)
      #   @param [Multidapter::Channel] channel_item (optional)
      #   @return [Dry::Monads::Result::Success, Dry::Monads::Result::Failure]
      params do
        required(:channel_id).value(:string)
        # optional(:channel_item).maybe(Multidapter::Channel)
        optional(:channel_item).maybe(:hash)
      end

    end
  end
end
