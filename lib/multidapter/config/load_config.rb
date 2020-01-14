# frozen_string_literal: true
# require "multidapter/log"

require 'i18n'
I18n.load_path << Dir[File.expand_path("lib/config/locales") + "/*.yml"]
I18n.default_locale = :en

module Multidapter
  module Operations
    class LoadConfig

      # step :read_file,  with: 'multidapter/operations/load_file'
      # step :parse_yml,  with: 'multidapter/operations/parse_yaml'

      # step :symbolize_keys,      with: 'resource_registry.serializers.symbolize_keys'
      # step :validate,            with: 'resource_registry.options.validate'
      # step :transform_option,    with: 'resource_registry.transactions.transform_option'

      private

      def validate(input)
        result = super

        if result.success?
          Success(result)
        else
          Failure(result.errors)
        end
      end
    end
  end
end
