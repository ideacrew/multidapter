# frozen_string_literal: true

module Multidapter
  module Validators
    class Contract < Dry::Validation::Contract
      config.messages.default_locale = :en
      # config.messages.backend = :i18n
      # config.messages.default_locale - default I18n-compatible locale identifier
      # config.messages.backend - the localization backend to use. Supported values are: :yaml and :i18n
      # config.messages.load_paths - an array of files paths that are used to load messages
      # config.messages.top_namespace - the key in the locale files under which messages are defined, by default it's dry_validation
      # config.messages.namespace - custom messages namespace for a contract class. Use this to differentiate common messages

      StrictSymbolizingHash = Types::Hash.schema({}).strict.with_key_transform(&:to_sym)

      rule(:components).each do
        if key? && value do
            result = ComponentContract.new.call(value)
            # Use dry-validation metadata form to pass error hash along with text to calling service
            key.failure(text: "invalid component hash", error: result.errors.to_h) if result && result.failure?
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

      rule(:channel_items).each do
        if key? && value do
            result = ChannelItemContract.new.call(value)
            # Use dry-validation metadata form to pass error hash along with text to calling service
            key.failure(text: "invalid channel_item hash", error: result.errors.to_h) if result && result.failure?
          end
        end
      end

      rule(:info) do
        if key? do
            result = InfoContract.new.call(value)
            # Use dry-validation metadata form to pass error hash along with text to calling service
            key.failure(text: "invalid info hash", error: result.errors.to_h) if result && result.failure?
          end
        end
      end

      rule(:message) do
        if key? do
            result = MessageContract.new.call(value)
            # Use dry-validation metadata form to pass error hash along with text to calling service
            key.failure(text: "invalid message hash", error: result.errors.to_h) if result && result.failure?
          end
        end
      end

      rule(:publish) do
        if key? do
            result = OperationContract.new.call(value)
            # Use dry-validation metadata form to pass error hash along with text to calling service
            key.failure(text: "invalid publish hash", error: result.errors.to_h) if result && result.failure?
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
