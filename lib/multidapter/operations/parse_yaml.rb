# frozen_string_literal: true
require 'yaml'

module Multidapter
  module Operations
    class ParseYaml
      include Dry::Transaction

      # rubocop:disable Security/YAMLLoad
      def call(input)
        # Success(YAML.load(ERB.new(input).result(b).binding))
        # stream = YAML.parse_stream(ERB.new(input).result)
        # Success(stream.to_yaml)

        YAML.load(ERB.new(input).result)


        Success(YAML.load(input))
      rescue Psych::SyntaxError => e
        Failure("Parse YAML failed: " + e.message)
      end
      # rubocop:enable Security/YAMLLoad

    end
  end
end
