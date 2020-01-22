# frozen_string_literal: true

module Multidapter
  module AsyncApi
    module Validators
      # SecuritySchemeSchema = Dry::Schema.Params do
      SecuritySchemeSchema = Dry::Schema.Params do

        required(:type).value(Types::SecuritySchemeType)
        optional(:description).maybe(:string)
        optional(:name).maybe(:string)
        optional(:in).maybe(:symbol)
        optional(:scheme).maybe(:string)
        optional(:bearer_format).maybe(:string)
        optional(:open_id_connect_url).maybe(Types::Url)
        optional(:flows).maybe(:hash)


        # rule(:in) do
        # end

        # rule(:scheme) do
        # end

        # rule(:bearer_format) do
        # end

        # rule(:open_id_connect_url) do
        # end

        # rule(:flows) do
        #   key.failure() if key? && (values[:type] != :oauth2)
        # end

      end
    end
  end
end
