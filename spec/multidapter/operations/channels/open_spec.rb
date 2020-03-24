# frozen_string_literal: true
require "spec_helper"

RSpec.describe Multidapter::Operations::Channels::Open do

  let(:channel_id)          { "user_enrollments" }
  let(:channel_item)        { { subscribe: { summary: 'A customer enrolled' } } }
  let(:required_params)     { { channel_id: channel_id } }
  let(:all_params)          { { channel_id: channel_id, channel_item: channel_item } }


  context "sending required parameters " do

    it "should create new Channel instance" do
      expect(subject.call(required_params).success?).to be_truthy
      expect(subject.call(required_params).success).to be_a Multidapter::Channel
    end

    it "should have attributes that match input params" do
      expect(subject.call(all_params).success.to_h).to eq all_params
    end
  end
end
