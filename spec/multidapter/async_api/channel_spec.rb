# frozen_string_literal: true
require "spec_helper"

RSpec.describe Multidapter::AsyncApi::Channel do

  let(:contract)  { Multidapter::AsyncApi::Validators::ChannelContract.new }

  context "Given valid required parameters" do
    let(:id)                  { "user_enrollments" }
    let(:channel)             { { id: id } }
    # let(:channel)             { { id: id, channel_items: [channel_item] } }
    let(:channel_item)        { { subscribe: { summary: 'A customer enrolled' } } }

    let(:required_params)     { channel }
    let(:all_params)          { channel.merge(channel_item) }

    context "with a Channel only" do
      it "should create new AmqpChannel instance" do

        # binding.pry
        expect(contract.call(required_params).to_h).to eq required_params
        expect(subject.call(required_params).value!).to be_a Multidapter::AsyncApi::Channel
      end
    end

    context "with a Channel and ChannelItem" do
      it "should create new AmqpChannel instance" do
        expect(subject.call(all_params).success?).to be_truthy
        expect(subject.call(all_params).value!).to be_a Multidapter::AsyncApi::Channel
      end
    end
  end


end
