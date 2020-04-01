# frozen_string_literal: true

module Multidapter
  module Validators

    # Schema and validation rules for {Multidapter::Tag} domain object
    class TagContract < Contract

      # @!method call(opts)
      # @param [Hash] opts the parameters to validate using this contract
      # @option opts [String] :name required
      # @option opts [String] :description optional
      # @option opts [Array<Hash>] :external_docs {ExternalDocumentation} optional
      # @return [Dry::Monads::Result::Success] if params pass validation
      # @return [Dry::Monads::Result::Failure] if params fail validation
      params do
        required(:name).filled(:string)
        optional(:description).maybe(:string)
        optional(:external_docs).array(:hash)
      end

    end
  end
end