# frozen_string_literal: true
# Allows adding meta data to a single tag

module Multidapter
  module AsyncApi
    class Tag

      OPTIONS_DEFAULT = {

        # Tag name (required)
        name:           "", 

        # short description for the tag. CommonMark syntax can be used for 
        # rich text representation
        description:    "",

        # Additional external documentation for this tag
        external_docs:  nil,
      }


      def initialize
      end

    end
  end
end
