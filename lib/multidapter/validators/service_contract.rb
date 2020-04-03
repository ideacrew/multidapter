# frozen_string_literal: true

module Multidapter
  module Validators

    # Schema and validation rules for {Service} domain object
    class ServiceContract < Contract

      # @!method call(opts)
      # @param [Hash] opts the parameters to validate using this contract
      # @option opts [String] :asyncapi required
      # @option opts [Hash] :info {Info} required
      # @option opts [Array<Hash>] :channels {Channel} required
      # @option opts [String] :id optional
      # @option opts [Array<Hash>] :servers {Server} optional
      # @option opts [Array<Hash>] :components {Component} optional
      # @option opts [Array<Hash>] :tags {Tag} optional
      # @option opts [Array<Hash>] :external_docs {ExternalDocumentation} optional
      # @return [Dry::Monads::Result::Success] if params pass validation
      # @return [Dry::Monads::Result::Failure] if params fail validation
      params do
        required(:asyncapi).value(:string)
        required(:info).value(:hash)
        required(:channels).array(:hash)
        optional(:id).maybe(:symbol)
        optional(:servers).array(Types::HashOrNil)
        optional(:components).array(Types::HashOrNil)
        optional(:tags).array(Types::HashOrNil)
        optional(:external_docs).array(Types::HashOrNil)

        # @!macro [attach] beforehook
        #   @!method $0($1)
        #   Coerce ID attribute to Symbol if passed as String
        before(:value_coercer) do |result|
          result.to_h.merge!({ id: result.to_h[:id].to_sym }) if result.to_h.has_key? :id
        end
      end

    end
  end
end
