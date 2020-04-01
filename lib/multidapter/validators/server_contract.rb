# frozen_string_literal: true
require 'json'

module Multidapter
  module Validators

    # Schema and validation rules for {Multidapter::Server} domain object
    class ServerContract < Contract

      # @!method call(opts)
      # @param [Hash] opts the parameters to validate using this contract
      # @option opts [String] :url required
      # @option opts [Symbol] :protocol required
      # @option opts [Types::StringOrNil] :protocol_version optional
      # @option opts [Types::StringOrNil] :description optional
      # @option opts [Array<Types::StringOrNil>] :variables optional
      # @option opts [Types::HashOrNil] :security optional
      # @option opts [Types::HashOrNil] :bindings optional
      # @return [Dry::Monads::Result::Success] if params pass validation
      # @return [Dry::Monads::Result::Failure] if params fail validation
      params do
        required(:url).value(:string)
        required(:protocol).value(:symbol)
        optional(:protocol_version).maybe(Types::StringOrNil)
        optional(:description).maybe(Types::StringOrNil)
        optional(:variables).array(:hash)
        optional(:security).maybe(Types::HashOrNil)
        optional(:bindings).maybe(Types::HashOrNil)

        # before(:value_coercer) do |result|
        #   result.to_h.merge(variables: []) if result[:variables] && result[:variables].nil?
        # end
      end

      rule(:protocol) do
        unless URI.scheme_list.keys.include?(value.to_s.upcase)
          key.failure('unsupported protocol')
        end
      end


      rule(:security) do
        if key? && value
          result = SecuritySchemeContract.new.call(value)
          # Use dry-validation metadata form to pass error hash along with text to calling service
          key.failure(text: "invalid security_scheme", error: result.errors.to_h) if result && result.failure?
        end
      end

    end
  end
end
