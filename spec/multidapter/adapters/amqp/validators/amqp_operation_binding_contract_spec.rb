# frozen_string_literal: true
require "spec_helper"

RSpec.describe Multidapter::Adapters::Amqp::Validators::AmqpOperationBindingContract do


  let(:expiration)      { 10_000 }
  let(:user_id)         { "guest" }
  let(:cc)              { [] }
  let(:priority)        { 10 }
  let(:delivery_mode)   { 2 }
  let(:mandatory)       { false }
  let(:bcc)             { [] }
  let(:reply_to)        { "user.enrolled" }
  let(:timestamp)       { true }
  let(:ack)             { false }
  let(:binding_version) { "0.2.0" }

  let(:all_params)      { {
                            expiration: expiration,
                            user_id: user_id,
                            cc: cc,
                            priority: priority,
                            delivery_mode: delivery_mode,
                            mandatory: mandatory,
                            bcc: bcc,
                            reply_to: reply_to,
                            timestamp: timestamp,
                            ack: ack,
                            binding_version: binding_version,
                          }
                          }

  context "When passed invalid parameters" do

    context "when parameters include an invalid :expiration value" do
      let(:invalid_expiration)  { -1 }
      let(:invalid_params)      { all_params.update(expiration: invalid_expiration) }
      let(:error_hash)          { {:expiration=>["must be greater than or equal to 0"]} }

      it "should return an error" do
        expect(subject.call(invalid_params).errors.to_h).to eq error_hash
      end
    end

    context "when parameters include an invalid :delivery_mode value" do
      let(:invalid_delivery_mode) { 0 }
      let(:invalid_params)        { all_params.update(delivery_mode: invalid_delivery_mode) }
      let(:error_hash)            { {:delivery_mode=>["must be one of: 1, 2"]} }

      it "should return an error" do
        expect(subject.call(invalid_params).errors.to_h).to eq error_hash
      end
    end

  end

  context "When passed valid parameters" do

    it "contract validation should pass" do
      expect(subject.call(all_params).to_h).to eq all_params
    end

    it "should create new Amqp Operation Binding instance" do
      amqp_operation_binding = Multidapter::Adapters::Amqp::AmqpOperationBinding.new(all_params)
      expect(amqp_operation_binding.to_h).to eq all_params
    end
  end


end
