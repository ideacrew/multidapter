# frozen_string_literal: true

module Multidapter
  module Validators

    # Schema and validation rules for {Multidapter::Tag} domain object
    class TagContract < Dry::Validation::Contract

      # @!method call(opts)
      # @param [Hash] opts the parameters to validate using this contract
      # @option opts [String] :name required
      # @option opts [String] :description optional
      # @option opts [Array<Hash>] :external_docs {ExternalDocumentation} optional
      # @return [Dry::Monads::Result::Success] if params pass validation
      # @return [Dry::Monads::Result::Failure] if params fail validation
      params do
        required(:name).filled(:string)
        required(:description).value(:string)
        required(:external_docs).array(:hash)
      end

      rule(:external_docs).each do
        if key? && value
          result = ExternalDocumentationContract.new.call(value)
          # Use dry-validation metadata form to pass error hash along with text to calling service
          key.failure(text: "invalid external_doc", error: result.errors.to_h) if result && result.failure?
        end
      end

    end
  end
end