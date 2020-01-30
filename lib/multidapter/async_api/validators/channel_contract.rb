# frozen_string_literal: true

module Multidapter
  module AsyncApi
    module Validators

      # Schema and validation rules for {Multidapter::AsyncApi::Channel}
      class ChannelContract < Dry::Validation::Contract

        # @!method call(Hash)
        #   @param [String] channel_id (optional)
        #   @param [Multidapter::AsyncApi::Channel] channel_item (optional)
        #   @return [Dry::Monads::Result::Success, Dry::Monads::Result::Failure]
        params do
          required(:channel_id).value(:string)
          optional(:channel_item).value(Multidapter::AsyncApi::Channel)
        end

      end
    end
  end
end
