# frozen_string_literal: true

module Multidapter
  module Messages
    module Validation
      MessageContract = Multidapter::Validation::ApplicationContract.build do

        params do
          required(:header).value(:hash)
          optional(:meta).maybe(:hash)
          required(:body).value(:any)
          optional(:attachments).array(:any) do
            required(:attachment).value(:any)
          end
        end
      end
    end
  end
end