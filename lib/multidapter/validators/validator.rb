# frozen_string_literal: true

require 'dry/validation'
require_relative 'contract'
require_relative 'tag_contract'
require_relative 'security_scheme_contract'
require_relative 'message_contract'
require_relative 'channel_contract'
require_relative 'channel_item_contract'
require_relative 'server_contract'
require_relative 'variable_contract'
require_relative 'info_contract'
require_relative 'service_contract'

# Dry::Validation.load_extensions(:monads)

module Multidapter
  module Validators

  end
end
