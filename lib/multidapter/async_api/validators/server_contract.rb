# frozen_string_literal: true
require 'json'

module Multidapter
  module AsyncApi
    module Validators

      class ServerContract < Dry::Validation::Contract

        params do
          required(:url).value(:string)
          required(:protocol).value(:symbol)
          optional(:protocol_version).maybe(Types::StringOrNil)
          optional(:description).maybe(Types::StringOrNil)
          optional(:variables).array(Types::HashOrNil)
          optional(:security).maybe(Types::HashOrNil)
          optional(:bindings).maybe(Types::HashOrNil)
        end

        rule(:protocol) do
          unless URI.scheme_list.keys.include?(value.to_s.upcase)
            key.failure('unsupported protocol')
          end
        end

        rule(:variables) do
          if key? && value

            value.each do |var|
              result = VariableContract.new.call({:key => var[:key], :value => var[:value]})
              key.failure(text: "invalid variable", error: result.errors.to_h) if result && result.failure?
            end

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
end
