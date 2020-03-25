# frozen_string_literal: true

module Multidapter
  module Validators

    # Schema and validation rules for {Multidapter::Component} domain object
    class ComponentContract < Contract

      # @!method call(opts)
      # @param [Hash] opts the parameters to validate using this contract
      # @option opts [String] :name required
      # @option opts [String] :description optional
      # @option opts [Array<Hash>] :external_docs {ExternalDocumentation} optional
      # @return [Dry::Monads::Result::Success] if params pass validation
      # @return [Dry::Monads::Result::Failure] if params fail validation
      params do
        required(:field).filled(:symbol)
        required(:map).hash do
          required(:key).value(:symbol)
          required(:object).array(:hash)
        end
      end


      rule(:field) do
        if key? && value do

# get field value and singularize
# constantize
# verify object is kind_of? object

            result = ChannelContract.new.call(value)
            # Use dry-validation metadata form to pass error hash along with text to calling service
            key.failure(text: "invalid channel", error: result.errors.to_h) if result && result.failure?

          end
        end

      end
    end
  end
end