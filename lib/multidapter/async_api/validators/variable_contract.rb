# frozen_string_literal: true
require 'json'

module Multidapter
  module AsyncApi
    module Validators

      ServerVariableSchema = Dry::Schema.Params do
        optional(:enum).array(:string)
        optional(:default).maybe(:string)
        optional(:description).maybe(:string)
        optional(:examples).maybe(:hash)
      end

      class VariableContract < Dry::Validation::Contract

        params do
          optional(:key).maybe(:symbol)
          optional(:value).maybe(ServerVariableSchema)
        end

      end
    end
  end
end
