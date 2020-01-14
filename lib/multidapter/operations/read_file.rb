# frozen_string_literal: true

module Multidapter
  module Operations
    class ReadFile
      include Dry::Transaction

      def call(input)
        return Failure("No such file or directory: " + input) unless File.exist?(input)
        return Failure("Unable to read file: " + input) unless File.readable?(input)

        Success(IO.read(File.open(input, "r")))
      rescue => e
        Failure("Read File failed: " + e.message)
      end
    end
  end
end
