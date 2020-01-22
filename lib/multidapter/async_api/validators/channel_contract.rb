# frozen_string_literal: true

module Multidapter
  module AsyncApi
    module Validators

      class ChannelContract < Dry::Validation::Contract

        params do
          required(:id).value(:string)
          # optional(:channel_items).hash do
            optional(:subscribe).value(:hash)
            optional(:publish).value(:hash)
          # end
        end

        # rule(:bindings) do
        #   if key?

        #   end
        # end

      end
    end
  end
end
