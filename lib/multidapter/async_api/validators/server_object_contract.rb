# frozen_string_literal: true
require 'json'

module Multidapter
  module AsyncApi
    module Validators
      class ServerObjectContract < Dry::Validation::Contract

        params do
          required(:url).value(:string)
          required(:protocol).value(:symbol)
          optional(:protocol_version).maybe(:string)
          optional(:description).maybe(:string)
          optional(:variables).maybe(:hash)
          optional(:security).maybe(:hash)
          optional(:bindings).maybe(:hash)
        end

        rule(:protocol) do
          unless URI.scheme_list.keys.include?(value.to_s.upcase)
            key.failure('unsupported protocol')
          end
        end

        rule(:security) do
          if key?
            result = SecuritySchemeSchema.call(value)
            # Use dry-validation metadata form to pass error hash along with text to calling service
            key.failure(text: "invalid security_scheme", error: result.errors.to_h) if result && result.failure?
          end
        end

      end
    end
  end
end
