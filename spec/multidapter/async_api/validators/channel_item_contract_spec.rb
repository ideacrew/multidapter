# frozen_string_literal: true

require "spec_helper"

RSpec.describe Multidapter::AsyncApi::Validators::ChannelItemContract do

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


  let(:common_params)          { {
                                   ref:          ref,
                                   description:  description,
                                   parameters:   parameters,
                                   bindings:     bindings,
                                   subscribe:    subscribe,
  } }

  context "Given invalid parameters" do
    context "Subscribe and Publish operations are both in same ChannelItem" do
      let(:params)        { common_params.merge(subscribe_operation).merge(publish_operation)}
      let(:error_message) { {:subscribe=>["inavlid channel_item: :subscribe and :publish operations not allowed in same instance"]} }

      it { expect(subject.call(params).failure?).to be_truthy }
      it { expect(subject.call(params).errors.to_h).to eq error_message }
    end
  end

  context "Given valid parameters" do
    let(:params)  { common_params.merge(subscribe_operation)}

    it "should pass validation" do
      expect(subject.call(params).success?).to be_truthy
      expect(subject.call(params).to_h).to eq params
    end
  end

end
