require "multidapter/version"
require "multidapter/errors"
require 'multidapter/types'

require "multidapter/log"
require "multidapter/config/load_config"
require "multidapter/operations"

require 'uri'
require 'securerandom'
require 'dry/struct'
require "multidapter/async_api/async_api"

# load_path = "lib/multidapter/operations"
# files << Dir[File.expand_path(load_path) + "/*.rb"]
# files.each { |file| require file }

# gem_root = File.dirname(File.absolute_path(__FILE__))
# Dir.glob(gem_root + 'lib/multidapter/operations/*.rb') { |file| require file }

require "multidapter/node"
require "multidapter/adapters"
require "multidapter/message"

module Multidapter

  module ClassMethods

    def generate_uuid
      SecureRandom.uuid
    end

    def generate_id
      generate_uuid
    end

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
