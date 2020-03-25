# frozen_string_literal: true

module Multidapter
  module Validators

    # Schema and validation rules for {Multidapter::Info} domain object
    class InfoContract < Contract

      # @!method call(opts)
      # @param [Hash] opts the parameters to validate using this contract
      # @option opts [String] :title required
      # @option opts [String] :version required
      # @option opts [String] :description optional
      # @option opts [String] :terms_of_service optional
      # @option opts [Hash] :contact optional
      # @option opts [Hash] :license optional
      # @return [Dry::Monads::Result::Success] if params pass validation
      # @return [Dry::Monads::Result::Failure] if params fail validation
      params do
        required(:title).filled(:string)
        required(:version).filled(:string)
        optional(:description).maybe(:string)
        optional(:terms_of_service).maybe(:string)

        optional(:contact).hash do
          optional(:name).maybe(:string)
          optional(:url).maybe(Types::Url)
          optional(:email).maybe(Types::Email)
        end

        optional(:license).hash do
          optional(:name).maybe(:string)
          optional(:url).maybe(Types::Url)
        end
      end

    end
  end
end