# frozen_string_literal: true
require "spec_helper"

RSpec.describe Multidapter::AsyncApi::Operations::CreateServer do

  let(:url)               { "amqp://example.com" }
  let(:protocol)          { :amqp }
  let(:security)          { { } }
  let(:security_scheme)   { { type: :user_password, description: "simple authentication" } }

  let(:required_params)   { { url: url, protocol: protocol } }
  let(:all_params)        { required_params.merge( { security: security_scheme} ) }

  context "sending required parameters " do

    it "should should create new Server instance" do
      expect(subject.call(required_params).success?).to be_truthy
      expect(subject.call(required_params).value!).to be_a Multidapter::AsyncApi::Server
    end

    it "should have attributes that match input params" do
      expect(subject.call(all_params).value!.to_h).to eq all_params
    end
  end
end
