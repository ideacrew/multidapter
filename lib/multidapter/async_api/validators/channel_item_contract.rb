# frozen_string_literal: true

module Multidapter
  module AsyncApi
    module Validators

      # Schema and validation rules for {Multidapter::AsyncApi::ChannelItem}
      class ChannelItemContract < Dry::Validation::Contract

        # @!method call(Hash)
        #   @param [String] ref (optional)
        #   @param [Hash] subscribe (optional)
        #   @param [Hash] publish (optional)
        #   @param [String] description (optional)
        #   @param [Types::HashOrNil] parameters (optional)
        #   @param [Hash] bindings (optional)
        #   @return [Dry::Monads::Result::Success, Dry::Monads::Result::Failure]
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
