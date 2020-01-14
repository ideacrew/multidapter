# frozen_string_literal: true

module Multidapter
  module Errors
    # @api private
    module ErrorInitalizer
      attr_reader :original

      def initialize(msg, original = $!)
        super(msg)
        @original = original
      end
    end

    # @api public
    class Error < StandardError
      include ErrorInitalizer
    end

    # Defined Errors
    DuplicateAdapterError     = Class.new(Error)
    ConnectionError           = Class.new(Error)
    AuthenticationError       = Class.new(Error)
    UnsupportedURIScheme      = Class.new(Error)

    DuplicateMessageFormatter = Class.new(Error)
  end
end
