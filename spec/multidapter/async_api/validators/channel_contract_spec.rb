# frozen_string_literal: true
require "spec_helper"

RSpec.describe Multidapter::AsyncApi::Validators::ChannelContract do

  # let(:subject)  { Multidapter::AsyncApi::Validators::Channelsubject.new }

  context "Given invalid required parameters" do
    let(:id)            { {} }
    let(:error_message) { { :id => ["is missing"] } }

    context "sending no parameters should fail validation with :errors" do
      it { expect(subject.call({}).failure?).to be_truthy }
      it { expect(subject.call({}).errors.to_h).to eq error_message }
    end
  end

  context "Given valid required parameters" do
    let(:id)                  { "user_enrollments" }
    let(:channel)             { { id: id} }
    let(:channel_items)       { { subscribe: { summary: 'A customer enrolled' } } }

    let(:required_params)     { channel }
    let(:all_params)          { channel.merge(channel_items) }

    context "with a Channel only" do
      it "should pass validation" do
        expect(subject.call(required_params).success?).to be_truthy
        expect(subject.call(required_params).to_h).to eq required_params
      end
    end

    context "with Channel and ChannelItem" do
      it "should pass validation" do
        expect(subject.call(all_params).success?).to be_truthy
      end
      it { expect(subject.call(all_params).to_h).to eq all_params }
    end
  end

end
