# frozen_string_literal: true

module Multidapter
  module AsyncApi
    class Server < Dry::Struct

      attribute :servers, Types::Hash.of(Multidapter::AsyncApi::ServerObject)
    end
  end
end