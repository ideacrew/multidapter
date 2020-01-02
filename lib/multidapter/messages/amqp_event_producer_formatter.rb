# frozen_string_literal: true

# Map Multidapter::Messages::Message to Cloudevent format
module Multidapter
  module Messages
    class AmqpEventProducerFormatter

      def call(message, serializer = nil)
        @message = message

        @header = @message[:header]
        @meta = @message[:meta] || {}
        @body = @message[:body] || {}
        @attachments = @message[:attachments] || []

        @serializer = serializer

        amqpeventproducer_message
      end


      private

      def amqpeventproducer_message
        {
          id:               id,
          publisher:        publisher,
          subject:          subject,
          identifier:       identifier,
          format:           format,
          # API
          source:           source,
          # GlobalID
          time:             current_time,
          data:             data,
        }
      end

      # Service (or person, organization) responsible for making the resource available
      # For example: benefit_marketplace.enroll_app.api.v2
      def publisher
        @header[:publisher]
      end

      # Command or event name from controlled vocabulary w/classification codes. 
      # For example benefit_marketplace.organization_created
      def subject
        @header[:subject]
      end

      # An unambiguous reference to the resource - Conforms to URI
      # GlobalID 
      def identifier
        @header[:identifier]
      end

      # Conforms to IANA mime types - http://www.iana.org/assignments/media-types/media-types.xhtml
      def format
        @header[:format] || "text/plain"
      end

      def current_time
        Time.now.utc.strftime('%FT%T%Z')
      end

      # unique ID for this message
      def id
        @header[:id] || generate_uuid
      end

      def data
        @body
      end

    end
  end
end
