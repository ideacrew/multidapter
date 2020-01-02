# frozen_string_literal: true

# Map Multidapter::Messages::Message to Cloudevent format
module Multidapter
  module Messages
    class CloudeventFormatter

      CLOUDEVENT_VERSION = "0.3"

      def call(message)
        @message = message

        @header = @message[:header]
        @meta = @message[:meta] || {}
        @body = @message[:body] || {}
        @attachments = @message[:attachments] || []

        cloudevent_message
      end


      private

      def cloudevent_message
        {
          specversion:      CLOUDEVENT_VERSION,
          type:             type,
          # API
          source:           source,
          subject:          "123", #
          # GlobalID
          id:               id,
          time:             current_time,
          datacontenttype:  datacontenttype,
          data:             data,
        }
      end

      # Service (or person, organization) responsible for making the resource available
      # For example: benefit_marketplace.enroll_app.api.v2
      def source
        @header[:publisher]
      end

      # Command or event name from controlled vocabulary w/classification codes. 
      # For example benefit_marketplace.organization_created
      def type
        @header[:subject]
      end

      # An unambiguous reference to the resource - Conforms to URI
      # GlobalID 
      def subject
        @header[:identifier]
      end

      # Conforms to IANA mime types - http://www.iana.org/assignments/media-types/media-types.xhtml
      def datacontenttype
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
