# frozen_string_literal: true
require "spec_helper"

RSpec.describe Multidapter::AsyncApi::Operations::CreateChannelItem do

  let(:ref)                   { "#/components/messages/user_enrolled" }
  let(:description)           { 'A customer enrolled' }
  let(:parameters)            { nil }
  let(:bindings)              { amqp_channel_bindings }
  let(:amqp_channel_bindings) { { amqp: {is: :queue, queue: { exclusive: true } } } }

  let(:subscribe)             { subscribe_operation }
  let(:subscribe_operation)   { { subscribe: { summary: 'A customer enrolled', message: message } } }

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


  let(:params)                { {
                                   ref:          ref,
                                   description:  description,
                                   parameters:   parameters,
                                   bindings:     bindings,
                                   subscribe:    subscribe,
  } }

  context "sending required parameters " do


    it "should should create new Channel instance" do
      expect(subject.call(params).success?).to be_truthy
      expect(subject.call(params).value!).to be_a Multidapter::AsyncApi::Channel
    end

    it "should have attributes that match input params" do
      expect(subject.call(params).value!.to_h).to eq all_params
    end

  end
end
