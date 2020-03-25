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

      rule(:channels).each do
        if key? && value
          result = ChannelContract.new.call(value)
          # Use dry-validation metadata form to pass error hash along with text to calling service
          key.failure(text: "invalid channel", error: result.errors.to_h) if result && result.failure?
        end
      end

      rule(:components).each do
        if key? && value
          result = ComponentContract.new.call(value)
          # Use dry-validation metadata form to pass error hash along with text to calling service
          key.failure(text: "invalid component", error: result.errors.to_h) if result && result.failure?
        end
      end

      rule(:external_docs).each do
        if key? && value
          result = ExternalDocumentationContract.new.call(value)
          # Use dry-validation metadata form to pass error hash along with text to calling service
          key.failure(text: "invalid external_doc", error: result.errors.to_h) if result && result.failure?
        end
      end

      rule(:servers).each do
        if key? && value
          result = ServerContract.new.call(value)
          # Use dry-validation metadata form to pass error hash along with text to calling service
          key.failure(text: "invalid server", error: result.errors.to_h) if result && result.failure?
        end
      end

      rule(:tags).each do
        if key? && value
          result = TagContract.new.call(value)
          # Use dry-validation metadata form to pass error hash along with text to calling service
          key.failure(text: "invalid tag", error: result.errors.to_h) if result && result.failure?
        end
      end

      rule(:variables).each do
        if key? && value
          value.each_pair do |k, v|
            result = VariableContract.new.call({:key => k, :value => v})
            # result = VariableContract.new.call(value)
            key.failure(text: "invalid variable", error: result.errors.to_h) if result && result.failure?
          end
        end
      end
    end
  end
end
