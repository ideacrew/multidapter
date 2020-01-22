# frozen_string_literal: true

module Multidapter
  class Node < AsyncApi::AsyncApi

    OPTION_DEFAULTS = {
      asyncapi: "2.0",
    }

    def initialize(application_id)
      @servers          = []
      @channels         = []
      @components       = []
      @tags             = []
      @external_docs    = []
    end

  end
end
