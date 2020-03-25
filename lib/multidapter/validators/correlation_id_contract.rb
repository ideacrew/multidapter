# frozen_string_literal: true

module Multidapter
  module Validators

    # Schema and validation rules for {Multidapter::CorrelationId} domain object
    class CorrelationIdContract < Contract

      # @!method call(opts)
      # @param [Hash] opts the parameters to validate using this contract
      # @option opts [String] :location required
      # @option opts [String] :description optional
      # @return [Dry::Monads::Result::Success] if params pass validation
      # @return [Dry::Monads::Result::Failure] if params fail validation
      params do
        required(:location).filled(:string)
        optional(:description).maybe(:string)
      end

    end
  end
end