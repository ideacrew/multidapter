# frozen_string_literal: true

message = Messages::Message.new do |msg|
  msg.routing_slip = routing_slip
  msg.add_header_key({from: "admin@ideacrew.com"})
  msg.body = "this is the body"

end


module Multidapter
  module Messages
    module Message

      HEADER_DEFAULTS =
      {
        id:               nil,        # => (UUID) unique identifier for this message
        type:             :object,    # => (Symbol) :text | :object (json) | :bytes
        meta:             {},         # => (Hash) application-defined properties

        # (String)
        # Identifier for message sender.  Service reference, email, URI for service, person, organization 
        # responsible for making the resource available
        # For example: http://openhbx.org/api/v2 or no_reply@openhbx.org
        publisher:        nil,

        # (String)
        # Command or event name from controlled vocabulary w/classification codes
        # For example: organizationos/rganization_created
        subject:          nil,

        # (URI)
        # An unambiguous reference to the resource - Conforms to URI - use GlobalID
        # For example: http://openhbx.org/api/v2/organizations/abc123
        identifier:       nil,

        # Conforms to IANA mime types - http://www.iana.org/assignments/media-types/media-types.xhtml
        format:           nil,
      }

      META_DEFAULTS =
      {
        to:               nil,        # => (URI) destination exchange or exchange/queue address
        submitted_at:     nil,        # => (UTC Time) timestamp when this message was enqueued
        context:          {},         # => (Hash) execution state, process flow and routing
      }

      attr_writer :header_keys, :routing_slip, :body, :attachments
      attr_reader :id

      def initialize(serializer = :json_api, &block)

        @id = Messages.generate_uuid
        @header_keys  = []
        @routing_slip = {}
        @attachments  = []

        build_message(&block) if block_given?

      end

      def self.call(&block)

      end

      def header_keys
        @header_keys
      end

      def body
      end

      def add_header_key(new_key_pair)
        @header_keys.delete_if { |key_pair| key_pair.key == new_key_pair.key  }
        @header_keys << new_key_pair
      end

      def add_attachment(attachment)
        @attachments << attachment
      end

      def routing_slip
      end

      def serialize
        @serializer.serialize(self)
      end


      module Messaging
        module Message

          def self.included(cls)
            cls.class_exec do
              include Schema::DataStructure

              extend Info
              extend Build
              extend Copy
              extend Follow
              extend Correlate

              const_set :Transform, Transform

              attribute :id, String
              attribute :metadata, Metadata, default: -> { Metadata.new }

              def self.transient_attributes
                [
                  :id,
                  :metadata
                ]
              end
            end
          end

          def message_type
            self.class.message_type
          end

          def message_name
            self.class.message_name
          end

          def follows?(other_message)
            metadata.follows?(other_message.metadata)
          end

          module Info
            extend self

            def message_type(msg=self)
              Info.class_name(msg).split('::').last
            end

            def message_type?(type)
              message_type == type
            end

            def message_name(msg=self)
              Info.canonize_name(message_type(msg))
            end

            def self.canonize_name(name)
              name.gsub(/([^\^])([A-Z])/,'\1_\2').downcase
            end

            def self.class_name(message)
              class_name = nil
              class_name = message if message.instance_of? String
              class_name ||= message.name if message.instance_of? Class
              class_name ||= message.class.name
              class_name
            end
          end

          module Build
            def build(data=nil, metadata=nil)
              data ||= {}
              metadata ||= {}

              metadata = build_metadata(metadata)

              new.tap do |instance|
                # Needed because Schema::DataStructure classes are expected
                # to support this protocol, but Message overrides build
                instance.transform_read(data)
                #

                set_attributes(instance, data)
                instance.metadata = metadata
              end
            end

            def set_attributes(instance, data)
              SetAttributes.(instance, data)
            end

            def build_metadata(metadata)
              if metadata.nil?
                Metadata.new
              else
                Metadata.build(metadata.to_h)
              end
            end
          end

          module Correlate
            def correlate(correlation_stream_name)
              instance = build
              instance.metadata.correlation_stream_name = correlation_stream_name
              instance
            end
          end
        end
      end


    end
  end
end
