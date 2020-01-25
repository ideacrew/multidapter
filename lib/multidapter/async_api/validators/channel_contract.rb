# frozen_string_literal: true

module Multidapter
  module AsyncApi
    module Validators

      class ChannelContract < Dry::Validation::Contract

        params do
          required(:channel_id).value(:string)
          optional(:channel_item).value(:hash)
        end

      end
    end
  end
end
