# frozen_string_literal: true

module Multidapter
  class Node

    # attr_reader   :logger

    OPTION_DEFAULTS = {
      # AsyncAPI spec version being used (required)
      asyncapi:       "2.0",

      # identifier of the application the AsyncApi is defining
      id:             'https://github.com/ideacrew/multidapter',

      # metadata about the API (required)
      info:           Multidapter::AsyncApi::Info,

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

    def self.call(uri, options = {})
      new(uri, options).connection
    end

    attr_reader :uri, :protocol, :protcol_versions, :options

    def initialize(uri, options = {})
      @connection       = nil
      @active           = false

      @servers          = []
      @channels         = []
      @components       = []
      @tags             = []
      @external_docs    = []


      @options = OPTION_DEFAULTS.merge(options)
    end

    def name
      @options[:protocol].to_s
    end

    def connection
    end

    def connect
    end

    def on_connect
    end

    def active?
    end

    def close
    end

    # Disconnects from server if already connected and establishes a new connection to server
    def reconnect
    end

    def logger(msg)
      @debug_output << msg + "\n" if @debug_output
    end

    def test_connection
      return true if active?

      begin
        connect
        if @active
          logger "#{name} connection test succeeded"
          true
        end
      ensure
        close
      end
    end


    private

    def log
    end

  end
end
