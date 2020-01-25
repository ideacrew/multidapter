# frozen_string_literal: true

module Multidapter
  module AsyncApi
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

      end
    end
  end
end
