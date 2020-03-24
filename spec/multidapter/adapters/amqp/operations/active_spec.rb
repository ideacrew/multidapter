# frozen_string_literal: true
require "spec_helper"

RSpec.describe Multidapter::Operations::Adapters::Active do

  let(:url)               { "amqp://127.0.0.1" }
  let(:protocol)          { :amqp }
  let(:protocol_version)  { "0.9.1" }
  let(:description)       { "RabbitMQ server" }
  let(:security_scheme)   { { type: :user_password, description: "simple authentication" } }
  let(:security)          { security_scheme }

  let(:server)            { {
                              url: url,
                              protocol: protocol,
                              protocol_version: protocol_version,
                              description: description,
                              security: security,
                            }
                            }


  context "With valid parameters" do

    it "should return a connection and server" do
      result = subject.call(server)

      expect(result.success?).to be_truthy
      expect(result.value!.first).to be_a Bunny::Session
      expect(Multidapter::Operations::Adapters::Active.call(result.value!.first)).to be_truthy
      expect(result.value!.last.value!).to be_a Multidapter::Server
    end
  end

  # context "sending required parameters " do

  #   it "should create new Server instance" do
  #     expect(subject.call(required_params).success).to be_truthy.and be_a(Multidapter::Server)
  #   end

  #   it "should have attributes that match input params" do
  #     result = subject.call(required_params).success.to_h

  #     expect(result[:url]).to be_a URI::AMQP
  #     expect(result.reject { |k,v| k == :url }).to eq required_params.reject { |k,v| k == :url }
  #   end
  # end

  # context "sending required parameters " do

  #   it "should should create new Server instance" do
  #     expect(subject.call(all_params).success).to be_truthy.and be_a(Multidapter::Server)
  #   end

  #   it "should have attributes that match input params" do
  #     result = subject.call(all_params).success.to_h

  #     expect(result[:url]).to be_a URI::AMQP
  #     expect(result.reject { |k,v| k == :url }).to eq all_params.reject { |k,v| k == :url }
  #   end
  # end

end
