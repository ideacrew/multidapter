# frozen_string_literal: true
require 'uri'

module Multidapter
  class Endpoint


      KINDS = {
        # amqp_producer_adapter: Multidapter::Adapters::AmqpProducerAdapter, # commands, events
        # amqp_consumer_adapter: Multidapter::Adapters::AmqpConsumerAdapter, # services, listeners

        # faraday or httparty - use HTTP/2
        # http_adapter: Multidapter::Adapters::HttpAdapter,
        # sftp_adapter: Multidapter::Adapters::SftpAdapter,
      }

     # URI scheme for this address
      URI_SCHEME        = 'uri'

      # URI attributes managed for all addresse types
      URI_COMPONENTS    = %w[userinfo host port path query].freeze

      # Key/Value pairs passed in via options hash that class will place in URI query attribute 
      QUERY_COMPONENTS  = %w[]

      attr_reader :userinfo, :host, :port, :path, :query, :scheme

      def initialize(**options)
        @scheme = URI_SCHEME
        @query_components = QUERY_COMPONENTS

        options.each_pair do |k, v|
          # rubocop:disable Style/RedundantSelf
          self.send("#{k}=", v)
          # rubocop:enable Style/RedundantSelf
        end

        self
      end

      def to_s
        host_and_port_str = [host, port].compact.join(":")
        query_str = query
        uri_str = scheme + "://" + 
                  [userinfo, ""].compact.join("@") + 
                  [host_and_port_str, path].compact.join("/")

        query_str.nil? ?  uri_str : uri_str + query_str
      end

      def to_uri
        URI.join(to_s)
      end

      # Construct the URI query component using passed values
      def query
        @query_components.reduce("") do |query_str, component|
          query_str + "?#{component}=#{instance_eval(component)}" if instance_eval(component).present?
        end
      end



  end
end
