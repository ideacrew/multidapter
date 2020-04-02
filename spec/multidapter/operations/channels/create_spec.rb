# frozen_string_literal: true

require "spec_helper"

RSpec.describe Multidapter::Operations::Channels::Create do

  let(:contract)  { Multidapter::Validators::ChannelContract.new }

  context "Given valid required parameters" do
    let(:channel_id)          { :user_enrollments }
    let(:channel_item)        { { subscribe: { summary: 'A customer enrolled' } } }
    let(:required_params)     { { channel_id: channel_id } }
    let(:all_params)          { { channel_id: channel_id, channel_item: channel_item } }

    context "with a Channel only" do

      it "contract validation should pass" do
        expect(contract.call(required_params).to_h).to eq required_params
      end

      it "should create new Channel instance" do
        expect(subject.call(required_params).value!).to be_a Multidapter::Channel
        expect(subject.call(required_params).value!.to_h).to eq required_params
      end
    end

    context "with a Channel and ChannelItem" do

      it "contract validation should pass" do
        expect(contract.call(all_params).to_h).to eq all_params
      end

      it "should create new Channel instance" do
        expect(subject.call(all_params).value!).to be_a Multidapter::Channel
        expect(subject.call(all_params).value!.to_h).to eq all_params
      end
    end

  end


end
