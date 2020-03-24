# frozen_string_literal: true

module Multidapter
  module Validators

    # Schema and validation rules for {Multidapter::SecurityScheme}
    class SecuritySchemeContract < Dry::Validation::Contract

      # @!method call(Hash)
      #   @param [Types::SecuritySchemeType] type (required)
      #   @param [String] description (optional)
      #   @param [String] name (optional)
      #   @param [Symbol] in (optional)
      #   @param [String] scheme (optional)
      #   @param [String] bearer_format (optional)
      #   @param [Types::Url] open_id_connect_url (optional)
      #   @param [Hash] flows (optional)
      #   @return [Dry::Monads::Result::Success, Dry::Monads::Result::Failure]
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
