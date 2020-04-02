# frozen_string_literal: true

module Multidapter
  module Validators

    # Schema and validation rules for {ChannelItem}
    class ChannelItemContract < Contract

      # @!method call(opts)
      # @param [Hash] opts the parameters to validate using this contract
      # @option opts [String] :ref optional
      # @option opts [Hash] :subscribe optional
      # @option opts [Hash] :publish optional
      # @option opts [String] :description optional
      # @option opts [Types::HashOrNil] :parameters optional
      # @option opts [Types::HashOrNil] :bindings optional
      # @return [Dry::Monads::Result::Success, Dry::Monads::Result::Failure]
      params do
        optional(:ref).value(:string)
        optional(:subscribe).value(:hash)
        optional(:publish).value(:hash)
        optional(:description).value(:string)
        optional(:parameters).value(Types::HashOrNil)
        optional(:bindings).value(Types::HashOrNil)
      end

    end

  end
end
