require "dry/transaction"

module Multidapter
  module Servers
    module Transactions
      class TestConnection
        include Dry::Transaction
        
        step :connect
        step :close

      end
    end
  end
end
