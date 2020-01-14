# frozen_string_literal: true

module Multidapter
  module AsyncApi
    module Validators

      ChannelItemSchema = Dry::Schema.Params do

        optional(:ref).value(:string)
        optional(:description).value(:string)
        optional(:subscribe).value(:hash)
        optional(:publish).value(:hash)
        optional(:parameters).value(:hash)
        optional(:bindings).value(:hash)

      end

      class ChannelContract < Dry::Validation::Contract


        rule(:bindings) do
          if key?

          end
        end

      end
    end
  end
end
