# frozen_string_literal: true
# AsyncAPI specification
# See: https://www.asyncapi.com/docs/specifications/2.0.0/

require_relative 'external_documentation'
require_relative 'schema'
require_relative 'tag'
require_relative 'info'
require_relative 'message_trait'
require_relative 'message'
require_relative 'operation_trait'
require_relative 'operation'
require_relative 'channel_item'
require_relative 'channel'
require_relative 'security_scheme'
require_relative 'server'
require_relative 'validators/validator'


module Multidapter
  module AsyncApi
    class AsyncApi

      SCHEMA_FORMATS =  {
        async_api_2_0_0:      [
          "application/vnd.aai.asyncapi;version=2.0.0", 
          "application/vnd.aai.asyncapi+json;version=2.0.0", 
          "application/vnd.aai.asyncapi+yaml;version=2.0.0"
        ],
        open_api_3_0_0:       [
          "application/vnd.oai.openapi;version=3.0.0", 
          "application/vnd.oai.openapi+json;version=3.0.0", 
          "application/vnd.oai.openapi+yaml;version=3.0.0"
        ],
        json_schema_draft_07: [
          "application/schema+json;version=draft-07", 
          "application/schema+yaml;version=draft-07"
      ],
        avro_1_9_0:           [
          "application/vnd.apache.avro;version=1.9.0", 
          "application/vnd.apache.avro+json;version=1.9.0", 
          "application/vnd.apache.avro+yaml;version=1.9.0"
        ],


      }

      OPTIONS_DEFAULT = {
        # AsyncAPI spec version being used (required)
        asyncapi:       "2.0",

        # identifier of the application the AsyncApi is defining
        id:             'https://github.com/ideacrew/multidapter',

        # metadata about the API (required)
        info:           {},

        # conection details of servers
        servers:        [],

        # available channels and messages for API (required)
        channels:       [],

        # container for schemas for the specification
        components:     [],

        # list of unique tags used by spec w/additional metadata
        tags:           [],

        # additional external documentation
        external_docs:  [],
      }

      def initialize

      end


    end
  end
end
