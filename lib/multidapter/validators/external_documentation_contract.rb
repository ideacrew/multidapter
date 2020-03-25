# frozen_string_literal: true

module Multidapter
  module Validators

    # Schema and validation rules for {Multidapter::ExternalDocument} domain object
    class ExternalDocumentationContract < Contract

      # @!method call(opts)
      # @param [Hash] opts the parameters to validate using this contract
      # @option opts [String] :description required
      # @option opts [Url] :url required
      # @return [Dry::Monads::Result::Success] if params pass validation
      # @return [Dry::Monads::Result::Failure] if params fail validation
      params do
        required(:description).value(:string)
        required(:url).filled(Types::Url)
      end

    end
  end
end