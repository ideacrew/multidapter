# frozen_string_literal: true

module Multidapter
  module AsyncApi
    module Validators
      # SecuritySchemeSchema = Dry::Schema.Params do
      class SecuritySchemeContract < Dry::Validation::Contract  

        params do
          required(:type).value(Types::SecuritySchemeType)
          optional(:description).maybe(:string)
          optional(:name).maybe(:string)
          optional(:in).maybe(:symbol)
          optional(:scheme).maybe(:string)
          optional(:bearer_format).maybe(:string)
          optional(:open_id_connect_url).maybe(Types::Url)
          optional(:flows).maybe(:hash)
        end
      end

    end
  end
end
