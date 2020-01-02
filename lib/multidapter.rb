require "multidapter/version"
require 'securerandom'
require 'uri'
require 'multidapter/types'
require 'dry/struct'


# Add custom URI schemes recognized by Multidapter
gem_root = File.dirname(File.absolute_path(__FILE__))
Dir.glob(gem_root + '/multidapter/uris/*.rb') { |file| require file }

require "multidapter/async_api/async_api"
require "multidapter/node"
require "multidapter/protocols/amqp_node"
# require "multidapter/log"
# require "multidapter/message"
# require "multidapter/endpoint"
# require "multidapter/server"

module Multidapter

  def self.generate_uuid
    SecureRandom.uuid
  end

  def self.generate_id
    generate_uuid
  end

  module ClassMethods

    # Turn on logging
    #   class Foo
    #     include HTTParty
    #     logger Logger.new('http_logger'), :info, :apache
    #   end

    def logger(logger, level = :info, format = :apache)
      default_options[:logger]     = logger
      default_options[:log_level]  = level
      default_options[:log_format] = format
    end
  end


end
