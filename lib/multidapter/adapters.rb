require 'bunny'

module Multidapter
  module Adapters
    require_relative 'adapter.rb'
    require_relative 'server.rb'
    require_relative 'channel.rb'

    @servers  = []
    @adapters = []
    @channels = []


    def self.add_server(new_server)
      @servers << new_server
    end

    def self.servers
      @servers
    end

    def self.add_adapter(new_adapter)
      @adapters << new_adapter
    end

    def self.adapters
      @adapters
    end


  end
end