# frozen_string_literal: true
require 'json'

module Multidapter
  module AsyncApi
    module Validators

      # @!group ServerVariableSchema
      # @!method call(Hash)
      #   @param [String] enum (optional)
      #   @param [String] default (optional)
      #   @param [String] description (optional)
      #   @param [Hash] examples (optional)
      #   @return [Dry::Monads::Result::Success, Dry::Monads::Result::Failure]
      ServerVariableSchema = Dry::Schema.Params do
        optional(:enum).array(:string)
        optional(:default).maybe(:string)
        optional(:description).maybe(:string)
        optional(:examples).maybe(:hash)
      end
      # @!endgroup

      # Schema and validation rules for {Multidapter::AsyncApi::Variable}
      class VariableContract < Dry::Validation::Contract

        # @!method call(Hash)
        #   @param [Symbol] key (optional)
        #   @param [ServerVariableSchema] value (optional)
        #   @return [Dry::Monads::Result::Success, Dry::Monads::Result::Failure]
        params do
          optional(:key).maybe(:symbol)
          optional(:value).maybe(ServerVariableSchema)
        end

      end
    end
  end
end
