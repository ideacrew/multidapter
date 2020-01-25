# frozen_string_literal: true
require "spec_helper"

RSpec.describe Multidapter::Adapters::Amqp::Validators::AmqpMessageBindingContract do

  let(:content_encoding)  { 'application/json' }
  let(:message_type)      { 'user.enroll' }
  let(:binding_version)   { "0.2.0" }

  let(:all_params)      { {
                            content_encoding: content_encoding,
                            message_type: message_type,
                            binding_version: binding_version,
                          }
                          }

  context "When passed invalid parameters" do

    context "when parameters include an invalid :content_encoding value" do
      let(:invalid_content_encoding)  { 'not_a_mime/type' }
      let(:invalid_params)      { all_params.update(content_encoding: invalid_content_encoding) }
      let(:error_hash)          { {:content_encoding=>["unknown Mime type: not_a_mime/type"]} }

      it "should return an error" do
        expect(subject.call(invalid_params).errors.to_h).to eq error_hash
      end
    end

  end

  context "When passed valid parameters" do

    it "contract validation should pass" do
      expect(subject.call(all_params).to_h).to eq all_params
    end

    it "should create new Amqp Message Binding instance" do
      amqp_message_binding = Multidapter::Adapters::Amqp::AmqpMessageBinding.new(all_params)
      expect(amqp_message_binding.to_h).to eq all_params
    end
  end


end
