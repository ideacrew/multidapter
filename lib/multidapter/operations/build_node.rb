# frozen_string_literal: true

module Multidapter
  module Operations
    class BuildNode
      include Dry::Transaction

      step :read_file,    with: 'read_file'
      step :parse_yaml,   with: 'parse_yaml'
      # step :validate
      step :build

      private

      def validate(input)
        contract = 
      end

      def build(input)

      end
    end
  end
end
