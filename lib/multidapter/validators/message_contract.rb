# frozen_string_literal: true

module Multidapter
  module Validators

    # Schema and validation rules for {Multidapter::Message}
    class MessageContract < Contract

      # @!method call(Hash)
      #   @param [Hash] headers optional
      #   @param [Mixed] payload optional
      #   @param [String] schema_format optional
      #   @param [String] content_type optional
      #   @param [String] name optional
      #   @param [String] title optional
      #   @param [String] summary optional
      #   @param [String] description optional
      #   @param [Array<Tag>] tags optional
      #   @param [ExternalDocumentation] external_docs optional
      #   @param [Hash] bindings optional
      #   @param [Array<Example>] examples optional
      #   @param [Array<Trait>] traits optional
      #   @return [Dry::Monads::Result::Success, Dry::Monads::Result::Failure]
      params do
        optional(:headers).maybe(Types::HashOrNil)
        optional(:payload).maybe(:any)
        optional(:schema_format).maybe(:string)
        optional(:content_type).maybe(:string)
        optional(:name).maybe(:string)
        optional(:title).maybe(:string)
        optional(:summary).maybe(:string)
        optional(:description).maybe(:string)
        optional(:tags).array(Types::HashOrNil)
        optional(:external_docs).array(Types::HashOrNil)
        optional(:bindings).maybe(Types::HashOrNil)
        optional(:examples).maybe(Types::HashOrNil)
        optional(:traits).array(Types::HashOrNil)

        before(:value_coercer) do |result|
          result.to_h.merge!({ external_docs: Array.new }) if (result.to_h.has_key?(:external_docs) && result.to_h[:external_docs].nil?)
        end
      end

    end

  end
end
