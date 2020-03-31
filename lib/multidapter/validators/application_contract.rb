# frozen_string_literal: true

module Multidapter
  module Validators

    # Schema and validation rules for {Application} domain object
    class ApplicationContract < Contract

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
        required(:info).value(:hash)
        required(:channels).array(:hash)
        optional(:id).maybe(:symbol)
        optional(:servers).array(Types::HashOrNil)
        optional(:components).array(Types::HashOrNil)
        optional(:tags).array(Types::HashOrNil)
        optional(:external_docs).array(Types::HashOrNil)
      end

      rule(:info) do
        if key? do
            result = InfoContract.new.call(value)
            # Use dry-validation metadata form to pass error hash along with text to calling service
            key.failure(text: "invalid info hash", error: result.errors.to_h) if result && result.failure?
          end
        end
      end

      rule(:channels).each do
        if key? && value do
            result = ChannelContract.new.call(value)
            # Use dry-validation metadata form to pass error hash along with text to calling service
            key.failure(text: "invalid channel hash", error: result.errors.to_h) if result && result.failure?
          end
        end
      end

      rule(:servers).each do
        if key? && value do
            result = ServerContract.new.call(value)
            # Use dry-validation metadata form to pass error hash along with text to calling service
            key.failure(text: "invalid server hash", error: result.errors.to_h) if result && result.failure?
          end
        end
      end

      rule(:components).each do
        if key? && value do
            result = ComponentContract.new.call(value)
            # Use dry-validation metadata form to pass error hash along with text to calling service
            key.failure(text: "invalid component hash", error: result.errors.to_h) if result && result.failure?
          end
        end
      end

      rule(:tags).each do
        if key? && value do
            result = TagContract.new.call(value)
            # Use dry-validation metadata form to pass error hash along with text to calling service
            key.failure(text: "invalid tag hash", error: result.errors.to_h) if result && result.failure?
          end
        end
      end

      rule(:external_docs).each do
        if key? && value do
            result = ExternalDocumentationContract.new.call(value)
            # Use dry-validation metadata form to pass error hash along with text to calling service
            key.failure(text: "invalid external_doc hash", error: result.errors.to_h) if result && result.failure?
          end
        end
      end


    end
  end
end
