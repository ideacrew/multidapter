# frozen_string_literal: true

module Multidapter
  module Validators

    # Schema and validation rules for {Multidapter::Adapter} domain object
    class AdapterContract < Contract

      # @!method call(opts)
      # @param [Hash] opts the parameters to validate using this contract
      # @option opts [String] :asyncapi required
      # @option opts [Hash] :info {Info} required
      # @option opts [Array<Hash>] :channels {Channel} required
      # @option opts [String] :id optional
      # @option opts [Array<Hash>] :servers {Server} optional
      # @option opts [Array<Hash>] :components {Component} optional
      # @option opts [Array<Hash>] :tags {Tag} optional
      # @option opts [Array<Hash>] :external_docs {ExternalDocument} optional
      # @return [Dry::Monads::Result::Success] if params pass validation
      # @return [Dry::Monads::Result::Failure] if params fail validation
      params do
        required(:asyncapi).value(:string)
        required(:info).filled(:hash)
        required(:channels).array(:hash)
        optional(:id).maybe(:symbol)
        optional(:servers).array(Types::HashOrNil)
        optional(:components).array(Types::HashOrNil)
        optional(:tags).array(Types::HashOrNil)
        optional(:external_docs).array(Types::HashOrNil)
      end

    end

  end
end
