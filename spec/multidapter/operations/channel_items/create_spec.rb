# frozen_string_literal: true

require "spec_helper"

RSpec.describe Multidapter::Operations::ChannelItems::Create do

  let(:ref)                   { "#/components/messages/user_enrolled" }
  let(:description)           { 'A customer enrolled' }
  let(:subscribe)             { { summary: 'A customer enrolled' } }
  let(:parameters)            { nil }
  let(:bindings)              { nil }



  let(:bindings)              { amqp_channel_bindings }
  let(:amqp_channel_bindings) { { amqp: {is: :queue, queue: { exclusive: true } } } }


  let(:publish)               { publish_operation }
  let(:publish_operation)     { { publish: { summary: 'Enroll a customer ', message: message } } }

  let(:message)               { { description: 'A longer description of message', payload: message_payload } }
  let(:multi_message)         { { one_of: [
                                    { ref: '#/components/messages/add_dependent' },
                                    { ref: '#/components/messages/cancel_enrollment' },
                                  ]
                                  } }

  let(:message_payload)       { { type: 'object',
                                  properties: {
                                    user:       { ref: '#/components/schemas/user'},
                                    enrollment: { ref: '#/components/schemas/enrollment'},
                                  }
                                  }
                                }


  let(:common_params)         { {
                                  ref:          ref,
                                  description:  description,
                                  subscribe:    subscribe,
                                  # parameters:   parameters,
                                  bindings:     bindings,
  } }

  context "sending required parameters " do

    it "should create new Channel instance" do
      expect(subject.call(common_params).success?).to be_truthy
      expect(subject.call(common_params).success).to be_a Multidapter::ChannelItem
    end

    it "should have attributes that match input common_params" do
      expect(subject.call(common_params).success.to_h).to eq common_params
    end

  end
end
