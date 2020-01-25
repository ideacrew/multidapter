# frozen_string_literal: true

module Multidapter
  module AsyncApi
    module Validators

      class ChannelItemContract < Dry::Validation::Contract

        params do
          optional(:ref).value(:string)
          optional(:subscribe).value(:hash)
          optional(:publish).value(:hash)
          optional(:description).value(:string)
          optional(:parameters).value(Types::HashOrNil)
          optional(:bindings).value(:hash)
        end

        rule(:subscribe) do
          if values.keys.include?(:publish)
            key.failure('invalid channel_item: :subscribe and :publish operations not allowed in same instance')
          end
        end

      end

    end
  end
end
