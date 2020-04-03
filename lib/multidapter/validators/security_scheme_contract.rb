# frozen_string_literal: true

module Multidapter
  module Validators

    # Schema and validation rules for {Multidapter::SecurityScheme}
    class SecuritySchemeContract < Contract

      # @!method call(opts)
      # @param [Hash] opts the parameters to validate using this contract
      # @option opts [Types::SecuritySchemeType] :type required
      # @option opts [String] :description optional
      # @option opts [String] :name optional
      # @option opts [Symbol] :in optional
      # @option opts [String] :scheme optional
      # @option opts [String] :bearer_format optional
      # @option opts [Types::Url] :open_id_connect_url optional
      # @option opts [Hash] :flows optional
      # @return [Dry::Monads::Result::Success, Dry::Monads::Result::Failure]
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
