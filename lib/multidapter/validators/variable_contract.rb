# frozen_string_literal: true
require 'json'

module Multidapter
  module Validators

    # @!method call(opts)
    # @param [Hash] opts the parameters to validate using this contract
    # @option opts [String] :enum (optional)
    # @option opts [String] :default (optional)
    # @option opts [String] :description (optional)
    # @option opts [Hash] :examples (optional)
    # @return [Dry::Monads::Result::Success, Dry::Monads::Result::Failure]
    ServerVariableSchema = Dry::Schema.Params do
      optional(:enum).maybe(:any)
      optional(:default).maybe(:any)
      optional(:description).maybe(:any)
      optional(:examples).maybe(:hash)
    end

    # Schema and validation rules for {Multidapter::Variable} domain object
    class VariableContract < Contract

      # @!method call(opts)
      # @param [Hash] opts the parameters to validate using this contract
      # @option opts [Symbol] :key (optional)
      # @option opts [ServerVariableSchema] :value (optional)
      # @return [Dry::Monads::Result::Success, Dry::Monads::Result::Failure]
      params do
        optional(:key).maybe(:symbol)
        optional(:value).maybe(ServerVariableSchema)
      end

    end
  end
end
