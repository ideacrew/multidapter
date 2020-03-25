# frozen_string_literal: true

module Multidapter

  # An object that specifies an identifier at design time that can used for message tracing and
  # correlation. For specifying and computing the location of a Correlation ID, a runtime
  # expression is used.
  class CorrelationId < Dry::Struct

    # @!attribute [r] location
    # A runtime expression that specifies the location of the correlation ID (required)
    #
    # A runtime expression allows values to be defined based on information that will be available within the message. This mechanism is used by Correlation ID Object.
    # The runtime expression is defined by the following {https://tools.ietf.org/html/rfc5234 ABNF} syntax:
    #       expression = ( "$message" "." source )
    #       source = ( header-reference | payload-reference )
    #       header-reference = "header." ["#" fragment]
    #       payload-reference = "payload." ["#" fragment]
    #       fragment = a JSON Pointer [RFC 6901](https://tools.ietf.org/html/rfc6901)
    # @example message header property
    #   "$message.header#/MQMD/CorrelId"
    # @example message payload property: 
    #   "$message.payload#/messageId"
    # @return [String]
    attribute :location,   Array.of(Multidapter::ExternalDocumentation).meta(omittable: false)

    # @!attribute [r] description
    # A short description for the identifier. CommonMark syntax can be used for
    # rich text representation
    # @return [String]
    attribute :description,     Types::String.meta(omittable: true)

  end
end
