# frozen_string_literal: true
require "spec_helper"

RSpec.describe Multidapter::AsyncApi::Operations::CreateChannel do

  let(:id)                  { "user_enrollments" }
  let(:channel)             { { id: id } }
  let(:channel_item)        { { subscribe: { summary: 'A customer enrolled' } } }

  let(:required_params)     { channel }
  let(:all_params)          { channel.merge(channel_item) }


  context "sending required parameters " do

    it "should should create new Channel instance" do
      expect(subject.call(required_params).success?).to be_truthy
      expect(subject.call(required_params).value!).to be_a Multidapter::AsyncApi::Channel
    end

    it "should have attributes that match input params" do
      expect(subject.call(all_params).value!.to_h).to eq all_params
    end
  end
end
